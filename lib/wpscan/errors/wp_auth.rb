# frozen_string_literal: true

module WPScan
  module Error
    # Raised when authenticated requests to the WP REST API are rejected.
    class WpAuthFailed < Standard
      def initialize(code, url)
        super()
        @code = code
        @url  = url
      end

      def to_s
        "Authenticated REST API request to #{@url} returned HTTP #{@code}. " \
          'WordPress core does NOT accept regular account passwords on /wp-json over Basic Auth. ' \
          'The password passed to --wp-auth must be a WordPress Application Password ' \
          '(WP >= 5.6): in wp-admin go to Users -> Profile -> Application Passwords, ' \
          'create one, and use the generated 24-character string (keep the spaces) as the password.'
      end
    end

    # Raised when the WP REST plugins/themes endpoint is unreachable for reasons
    # other than authentication (404, 5xx, security plugins blocking /wp-json, ...).
    class WpAuthEndpointUnavailable < Standard
      def initialize(code, url)
        super()
        @code = code
        @url  = url
      end

      def to_s
        "Authenticated REST API endpoint #{@url} returned HTTP #{@code}. " \
          'The endpoint may be disabled, blocked, or require WordPress 5.5+.'
      end
    end
  end
end
