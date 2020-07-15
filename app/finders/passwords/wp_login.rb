# frozen_string_literal: true

module WPScan
  module Finders
    module Passwords
      # Password attack against the wp-login.php
      class WpLogin < CMSScanner::Finders::Finder
        include CMSScanner::Finders::Finder::BreadthFirstDictionaryAttack

        def login_request(username, password)
          target.login_request(username, password)
        end

        def valid_credentials?(response)
          response.code == 302 &&
            Array(response.headers['Set-Cookie'])&.any? { |cookie| cookie =~ /wordpress_logged_in_/i }
        end

        def errored_response?(response)
          response.code != 200 && response.body !~ /login_error/i
        end
      end
    end
  end
end
