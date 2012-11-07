module ProjectRazor
    # ProjectRazor::Client Exceptions.
    module Exception
      # ProjectRazor Client Exception: Authorization Error.
      class AuthError < RuntimeError; end
      # ProjectRazor Client Exception: Bad Parameters.
      class BadParams < RuntimeError; end
      # ProjectRazor Client Exception: Bad Response Received.
      class BadResponse < RuntimeError; end

      # ProjectRazor Cloud Exception: Bad Request.
      class BadRequest < RuntimeError; end
      # ProjectRazor Cloud Exception: Forbidden.
      class Forbidden < RuntimeError; end
      # ProjectRazor Cloud Exception: Not Found.
      class NotFound < RuntimeError; end
      # ProjectRazor Cloud Exception: Server Error.
      class ServerError < RuntimeError; end
      # ProjectRazor Cloud Exception: Bad Gateway.
      class BadGateway < RuntimeError; end
    end
end