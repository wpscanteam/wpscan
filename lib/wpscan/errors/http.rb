# frozen_string_literal: true

module WPScan
  module Error
    # Generic HTTP Error
    class HTTP < Standard
      attr_reader :response

      # @param [ Typhoeus::Response ] response
      def initialize(response)
        @response = response
      end

      def failure_details
        msg = response.effective_url

        msg += if response.code.zero? || response.timed_out?
                 " (#{response.return_message})"
               else
                 " (status: #{response.code})"
               end

        msg
      end

      def to_s
        "HTTP Error: #{failure_details}"
      end
    end

    # Used in the Updater
    class Download < HTTP
      def to_s
        "Unable to get #{failure_details}"
      end
    end

    # Target Down Error
    class TargetDown < Standard
      attr_reader :response

      def initialize(response)
        @response = response
      end

      def to_s
        "The url supplied '#{response.request.url}' seems to be down (#{response.return_message})"
      end
    end

    # HTTP Authentication Required Error
    class HTTPAuthRequired < Standard
      # :nocov:
      def to_s
        'HTTP authentication required (or was invalid), please provide it with --http-auth'
      end
      # :nocov:
    end

    # Proxy Authentication Required Error
    class ProxyAuthRequired < Standard
      # :nocov:
      def to_s
        'Proxy authentication required (or was invalid), please provide it with --proxy-auth'
      end
      # :nocov:
    end

    # Access Forbidden Error
    class AccessForbidden < Standard
      attr_reader :random_user_agent_used

      # @param [ Boolean ] random_user_agent_used
      def initialize(random_user_agent_used)
        @random_user_agent_used = random_user_agent_used
      end

      def to_s
        msg = if random_user_agent_used
                'Well... --random-user-agent didn\'t work, use --force to skip this check if needed.'
              else
                'Please re-try with --random-user-agent'
              end

        "The target is responding with a 403, this might be due to a WAF. #{msg}"
      end
    end

    # HTTP Redirect Error
    class HTTPRedirect < Standard
      attr_reader :redirect_uri

      # @param [ String ] url
      def initialize(url)
        @redirect_uri = Addressable::URI.parse(url).normalize
      end

      def to_s
        "The URL supplied redirects to #{redirect_uri}. Use the --ignore-main-redirect " \
          'option to ignore the redirection and scan the target, or change the --url option ' \
          'value to the redirected URL.'
      end
    end
  end
end
