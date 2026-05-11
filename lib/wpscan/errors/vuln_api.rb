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

    # Error raised when trying to enumerate vulnerable plugins/themes without an API token
    class ApiTokenRequiredForVulnerableEnumeration < Standard
      def to_s
        'An API token is required for vulnerable plugin/theme enumeration. ' \
          'You can get a free API token with 25 daily requests by registering at https://wpscan.com/register. ' \
          'Provide it via --api-token TOKEN or the WPSCAN_API_TOKEN environment variable.'
      end
    end

    # Error raised when there's a connection issue with the WPScan API
    class ApiConnectionError < Standard
      attr_reader :original_error

      def initialize(original_error)
        @original_error = original_error
        super()
      end

      def to_s
        "Unable to connect to the WPScan API: #{original_error}. " \
          'Please check https://status.wpscan.com/ for service status.'
      end
    end
  end
end
