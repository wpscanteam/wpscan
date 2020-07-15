# frozen_string_literal: true

module WPScan
  module Finders
    module Users
      # Login Error Messages
      #
      # Existing username:
      #   WP < 3.1 - Incorrect password.
      #   WP >= 3.1 - The password you entered for the username admin is incorrect.
      # Non existent username: Invalid username.
      #
      class LoginErrorMessages < CMSScanner::Finders::Finder
        # @param [ Hash ] opts
        # @option opts [ String ] :list
        #
        # @return [ Array<User> ]
        def aggressive(opts = {})
          found = []

          usernames(opts).each do |username|
            res   = target.do_login(username, SecureRandom.hex[0, 8])
            error = res.html.css('div#login_error').text.strip

            return found if error.empty? # Protection plugin / error disabled

            next unless /The password you entered for the username|Incorrect Password/i.match?(error)

            found << Model::User.new(username, found_by: found_by, confidence: 100)
          end

          found
        end

        # @return [ Array<String> ] List of usernames to check
        def usernames(opts = {})
          # usernames from the potential Users found
          unames = opts[:found].map(&:username)

          Array(opts[:list]).each { |uname| unames << uname.chomp }

          unames.uniq
        end
      end
    end
  end
end
