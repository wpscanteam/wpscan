# frozen_string_literal: true

module WPScan
  module Finders
    module Passwords
      # Password attack against the XMLRPC interface
      class XMLRPC < WPScan::Finders::Finder
        include WPScan::Finders::Finder::BreadthFirstDictionaryAttack

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
