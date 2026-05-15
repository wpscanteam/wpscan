# frozen_string_literal: true

module WPScan
  module Error
    # SAML Authentication Required Error
    class SAMLAuthenticationRequired < Standard
      # :nocov:
      def to_s
        'SAML authentication is required to access this resource, consider using --expect-saml.'
      end
      # :nocov:
    end

    # SAML Authentication Failed Error
    class SAMLAuthenticationFailed < Standard
      # :nocov:
      def to_s
        'SAML authentication is required to access this resource. ' \
          'Please ensure correct authentication credentials.'
      end
      # :nocov:
    end

    # SAML Authentication Failed Error
    class AuthenticatedRescanFailure < Standard
      attr_reader :command

      # @param [ String ] url
      def initialize(wpscan_command)
        @command = wpscan_command
      end

      # :nocov:
      def to_s
        "Following authentication, the system failed to execute follow-up command: #{command}"
      end
      # :nocov:
    end

    # Ferrum Browser Error
    class BrowserFailed < Standard
      # :nocov:
      def to_s
        'The browser was closed or failed before authentication could be completed.'
      end
      # :nocov:
    end
  end
end
