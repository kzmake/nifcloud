require 'httpclient'
require 'xmlsimple'

module Niftycloud
  class Request
    attr_accessor :secret_key, :access_key, :endpoint

    def get(path, options={})
      set_query(options)
      validate create_client.get(@endpoint + path, options)
    end

    def post(path, options={})
      set_query(options)
      validate create_client.post(@endpoint + path, options)
    end

    def put(path, options={})
      set_query(options)
      validate create_client.put(@endpoint + path, options)
    end

    def delete(path, options={})
      set_query(options)
      validate create_client.delete(@endpoint + path, options)
    end

    private
    def parse(xml)
      options = {'forcearray' => ['item', 'member'], 'suppressempty' => nil, 'keeproot' => false}
      body = XmlSimple.xml_in(xml, options)

      if body.is_a? Hash
        body.extend ObjectifiedHash
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

    def create_client
      client = HTTPClient.new default_header: {"User-Agent" => @user_agent}
      client.debug_dev = $stderr if @debug

      client
    end

    def validate(response)
      error_klass =
          case response.code
            when 400 then
              Error::BadRequest
            when 401 then
              Error::Unauthorized
            when 403 then
              Error::Forbidden
            when 404 then
              Error::NotFound
            when 405 then
              Error::MethodNotAllowed
            when 409 then
              Error::Conflict
            when 422 then
              Error::Unprocessable
            when 500 then
              Error::InternalServerError
            when 502 then
              Error::BadGateway
            when 503 then
              Error::ServiceUnavailable
          end

      response_obj = parse response.body
      fail error_klass.new(response_obj.Errors.Error) if error_klass
      response_obj
    end

    def set_query(options={})
      set_timestamp(options)
      set_access_key(options)
      set_signature(options)
    end

    def set_header(options={})
      options.merge!(header: {'User-Agent' => self.user_agent})
    end

    def set_timestamp(options)
      options[:query][:Timestamp] = Time.now.strftime("%Y%m%dT%H:%M:%SZ")
    end

    def set_access_key(options)
      options[:query][:AccessKeyId] = access_key
    end

    def set_signature(options)
      key = @secret_key
      data = "#{options[:query][:Action]}#{options[:query][:Timestamp]}"
      options[:query][:Signature] = Signature.v0(key, data)
      options[:query][:SignatureVersion] = '0'
    end
  end
end
