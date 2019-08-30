# frozen_string_literal: true

module WPScan
  module Error
    # Error raised when the token given via --api-token is invalid
    class InvalidApiToken < Standard
      def to_s
        'The API token provided is invalid'
      end
    end

    # Error raised when the number of API requests has been reached
    # currently not implemented on the API side
    class ApiLimitReached < Standard
      def to_s
        'Your API limit has been reached'
      end
    end
  end
end
