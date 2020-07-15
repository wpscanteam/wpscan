# frozen_string_literal: true

module WPScan
  module Finders
    module Passwords
      # Password attack against the XMLRPC interface
      class XMLRPC < CMSScanner::Finders::Finder
        include CMSScanner::Finders::Finder::BreadthFirstDictionaryAttack

        def login_request(username, password)
          target.method_call('wp.getUsersBlogs', [username, password], cache_ttl: 0)
        end

        def valid_credentials?(response)
          response.code == 200 && response.body.include?('blogName')
        end

        def errored_response?(response)
          response.code != 200 && response.body !~ /Incorrect username or password/i
        end
      end
    end
  end
end
