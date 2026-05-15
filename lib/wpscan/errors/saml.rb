# frozen_string_literal: true

module WPScan
  module Error
    # SAML Authentication Required Error
    class SAMLAuthenticationRequired < Standard
      def to_s
        'SAML authentication is required to access this resource, consider using --expect-saml.'
      end
    end

    # SAML Authentication Failed Error
    class SAMLAuthenticationFailed < Standard
      def to_s
        'SAML authentication is required to access this resource. ' \
          'Please ensure correct authentication credentials.'
      end
    end

    # Ferrum Browser Error
    class BrowserFailed < Standard
      def to_s
        'The browser was closed or failed before authentication could be completed.'
      end
    end
  end
end
