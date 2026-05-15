# frozen_string_literal: true

module WPScan
  module Error
    # SAML Authentication Required Error
    class SAMLAuthenticationRequired < Standard
      def initialize(message = 'SAML authentication is required to access this resource, consider using --expect-saml.')
        super
      end
    end

    # SAML Authentication Failed Error
    class SAMLAuthenticationFailed < Standard
      def initialize(message = 'SAML authentication is required to access this resource. ' \
                               'Please ensure correct authentication credentials.')
        super
      end
    end

    # Ferrum Browser Error. Callers should pass a context-specific message
    # (missing Chrome binary, non-interactive terminal, browser closed mid-auth, ...).
    class BrowserFailed < Standard
      def initialize(message = 'The browser was closed or failed before SAML authentication could be completed.')
        super
      end
    end
  end
end
