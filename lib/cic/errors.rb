module Cic
  class CicError < StandardError; end

  module Exception 

    class APIError < ::Cic::CicError
      attr_accessor :http_status, :response_body

      def initialize(http_status, response_body, error_info = nil)
        message = " [HTTP #{http_status}] #{response_body}"
        super(message)
      end
    end

    # Any error with a 5xx HTTP status code
    class ServerError < APIError; end

    # Any error with a 4xx HTTP status code
    class ClientError < APIError; end
  end
end
