require 'httparty'
require 'json'

module Niftycloud
  class Request
    include HTTParty
    format :json
    headers 'Accept' => 'application/json'
    parser proc { |body, _| parse(body) }

    attr_accessor :private_token, :endpoint

    def self.parse(body)
      body = decode(body)

      if body.is_a? Hash
        ObjectifiedHash.new body
      elsif body.is_a? Array
        PaginatedResponse.new(body.collect! { |e| ObjectifiedHash.new(e) })
      elsif body
        true
      elsif !body
        false
      elsif body.nil?
        false
      else
        raise Error::Parsing.new "Couldn't parse a response body"
      end
    end

    def self.decode(response)
      JSON.load response
    rescue JSON::ParserError
      raise Error::Parsing.new "The response is not a valid JSON"
    end

    def get(path, options={})
      set_httparty_config(options)
      set_authorization_header(options)
      validate self.class.get(@endpoint + path, options)
    end

    def post(path, options={})
      set_httparty_config(options)
      set_authorization_header(options)
      validate self.class.post(@endpoint + path, options)
    end

    def put(path, options={})
      set_httparty_config(options)
      set_authorization_header(options)
      validate self.class.put(@endpoint + path, options)
    end

    def delete(path, options={})
      set_httparty_config(options)
      set_authorization_header(options)
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

    def set_authorization_header(options)
      unless options[:unauthenticated]
        raise Error::MissingCredentials.new("Please provide a private_token or auth_token for user") unless @private_token
        if @private_token.length <= 20
          options[:headers] = { 'PRIVATE-TOKEN' => @private_token }
        else
          options[:headers] = { 'Authorization' => "Bearer #{@private_token}" }
        end
      end
    end

    def set_httparty_config(options)
      options.merge!(httparty) if httparty
    end

  end
end