require 'httparty'
require 'rexml/document'
require 'json'

module Niftycloud
  class Request
    include HTTParty
    format :json
    headers 'Accept' => 'application/json'
    parser proc { |body, _| parse(body) }

    attr_accessor :secret_key, :access_key, :endpoint

    def self.parse(body)
      body = REXML::Document.new(body).root.to_h["reservationSet"]

      if body.is_a? Hash
        ObjectifiedHash.new body
      elsif body.is_a? Array
        PaginatedResponse.new(body.collect! { |e| ObjectifiedHash.new(e) })
      elsif body
        body
      elsif !body
        false
      elsif body.nil?
        false
      else
        raise Error::Parsing.new "Couldn't parse a response body"
      end
    end

    def self.decode(response)
      p response 
      JSON.load response
    rescue JSON::ParserError
      raise Error::Parsing.new "The response is not a valid JSON"
    end

    def get(path, options={})
      set_access_key(options)
      set_signature(options)
      set_httparty_config(options)
      validate self.class.get(@endpoint + path, options) 
    end

    def post(path, options={})
      set_access_key(options)
      set_signature(options)
      set_httparty_config(options)
      validate self.class.post(@endpoint + path, options)
    end

    def put(path, options={})
      set_access_key(options)
      set_signature(options)
      set_httparty_config(options)
      validate self.class.put(@endpoint + path, options)
    end

    def delete(path, options={})
      set_access_key(options)
      set_signature(options)
      set_httparty_config(options)
      validate self.class.delete(@endpoint + path, options)
    end

    def validate(response)
      error_klass = case response.code
      when 400 then Error::BadRequest
      when 401 then Error::Unauthorized
      when 403 then Error::Forbidden
      when 404 then Error::NotFound
      when 405 then Error::MethodNotAllowed
      when 409 then Error::Conflict
      when 422 then Error::Unprocessable
      when 500 then Error::InternalServerError
      when 502 then Error::BadGateway
      when 503 then Error::ServiceUnavailable
      end

      fail error_klass.new(response) if error_klass

      parsed = response.parsed_response
      parsed.client = self if parsed.respond_to?(:client=)
      parsed.parse_headers!(response.headers) if parsed.respond_to?(:parse_headers!)
      parsed
    end

    def set_request_defaults(sudo=nil)
      self.class.default_params sudo: sudo
      raise Error::MissingCredentials.new("Please set an endpoint to API") unless @endpoint
      self.class.default_params.delete(:sudo) if sudo.nil?
    end

    private
    def set_access_key(options)
      options[:query][:AccessKeyId] = access_key
    end

    def set_signature(options)
      key = @secret_key
      data = "#{options[:query][:Action]}#{options[:query][:Timestamp]}"
      options[:query][:Signature] = Signature.v0(key, data)
    end

    def set_httparty_config(options)
      options.merge!(httparty) if httparty
    end

  end
end

class REXML::Element
  def to_h
    hash = {}
    if self.has_elements?
      self.elements.each do |e|
        if e.has_elements?
          if hash[e.name].nil?
            hash[e.name] = e.to_h
          elsif hash[e.name].is_a?(Array)
            hash[e.name].push( e.to_h )
          else
            hash[e.name] = [ hash[e.name] ]
            hash[e.name].push( e.to_h )
          end
        elsif e.has_text?
          hash[e.name] = e.text
        end
      end
    else
      hash[self.name] = self.text
    end
    hash
  end
end
