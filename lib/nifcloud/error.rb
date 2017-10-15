module Nifcloud
  module Error
    # Custom error class for rescuing from all errors.
    class Error < StandardError;
    end

    # Raised when API endpoint credentials not configured.
    class MissingCredentials < Error;
    end

    # Raised when impossible to parse response body.
    class Parsing < Error;
    end

    # Custom error class for rescuing from HTTP response errors.
    class ResponseError < Error
      def initialize(response)
        @response = response
        super(build_error_message)
      end

      # Status code returned in the http response.
      #
      # @return [Integer]
      def response_status
        (@response != false) ? @response.Code : "?"
      end

      private

      # Human friendly message.
      #
      # @return [String]
      def build_error_message
        message = @response.Message if @response != false
        message = "false" if @response == false

        "Server responded with code #{@response.Code}, \n message: #{handle_message(message)}. \n\n"
      end

      # Handle error response message in case of nested hashes
      def handle_message(message)
        case message
          #when Nifcloud::ObjectifiedHash
          #  message.to_h.sort.map do |key, val|
          #    "'#{key}' #{(val.is_a?(Hash) ? val.sort.map { |k, v| "(#{k}: #{v.join(' ')})" } : val).join(' ')}"
          #  end.join(', ')
          when Array
            message.join(' ')
          else
            message
        end
      end
    end

    # Raised when API endpoint returns the HTTP status code 400.
    class BadRequest < ResponseError;
    end

    # Raised when API endpoint returns the HTTP status code 401.
    class Unauthorized < ResponseError;
    end

    # Raised when API endpoint returns the HTTP status code 403.
    class Forbidden < ResponseError;
    end

    # Raised when API endpoint returns the HTTP status code 404.
    class NotFound < ResponseError;
    end

    # Raised when API endpoint returns the HTTP status code 405.
    class MethodNotAllowed < ResponseError;
    end

    # Raised when API endpoint returns the HTTP status code 409.
    class Conflict < ResponseError;
    end

    # Raised when API endpoint returns the HTTP status code 422.
    class Unprocessable < ResponseError;
    end

    # Raised when API endpoint returns the HTTP status code 500.
    class InternalServerError < ResponseError;
    end

    # Raised when API endpoint returns the HTTP status code 502.
    class BadGateway < ResponseError;
    end

    # Raised when API endpoint returns the HTTP status code 503.
    class ServiceUnavailable < ResponseError;
    end
  end
end
