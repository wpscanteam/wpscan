module WPScan
  module Controller
    # Password Attack Controller
    class PasswordAttack < CMSScanner::Controller::Base
      def cli_options
        [
          OptFilePath.new(
            ['--passwords FILE-PATH', '-P',
             'List of passwords to use during the password attack.',
             'If no --username/s option supplied, user enumeration will be run.'],
            exists: true
          ),
          OptSmartList.new(['--usernames LIST', '-U', 'List of usernames to use during the password attack.']),
          OptInteger.new(['--multicall-max-passwords MAX_PWD',
                          'Maximum number of passwords to send by request with XMLRPC multicall'],
                         default: 500),
          OptChoice.new(['--password-attack ATTACK',
                         'Force the supplied attack to be used rather than automatically determining one.'],
                        choices: %w[wp-login xmlrpc xmlrpc-multicall],
                        normalize: %i[downcase underscore to_sym])
        ]
      end

      def run
        return unless parsed_options[:passwords]

        if user_interaction?
          output('@info',
                 msg: "Performing password attack on #{attacker.titleize} against #{users.size} user/s")
        end

        attack_opts = {
          show_progression: user_interaction?,
          multicall_max_passwords: parsed_options[:multicall_max_passwords]
        }

        begin
          found = []

          attacker.attack(users, passwords(parsed_options[:passwords]), attack_opts) do |user|
            found << user

            attacker.progress_bar.log("[SUCCESS] - #{user.username} / #{user.password}")
          end
        ensure
          output('users', users: found)
        end
      end

      # @return [ CMSScanner::Finders::Finder ] The finder used to perform the attack
      def attacker
        @attacker ||= attacker_from_cli_options || attacker_from_automatic_detection
      end

      # @return [ WPScan::XMLRPC ]
      def xmlrpc
        @xmlrpc ||= target.xmlrpc
      end

      # @return [ CMSScanner::Finders::Finder ]
      def attacker_from_cli_options
        return unless parsed_options[:password_attack]

        case parsed_options[:password_attack]
        when :wp_login
          WPScan::Finders::Passwords::WpLogin.new(target)
        when :xmlrpc
          WPScan::Finders::Passwords::XMLRPC.new(xmlrpc)
        when :xmlrpc_multicall
          WPScan::Finders::Passwords::XMLRPCMulticall.new(xmlrpc)
        end
      end

      # @return [ CMSScanner::Finders::Finder ]
      def attacker_from_automatic_detection
        if xmlrpc&.enabled? && xmlrpc.available_methods.include?('wp.getUsersBlogs')
          wp_version = target.wp_version

          if wp_version && wp_version < '4.4'
            WPScan::Finders::Passwords::XMLRPCMulticall.new(xmlrpc)
          else
            WPScan::Finders::Passwords::XMLRPC.new(xmlrpc)
          end
        else
          WPScan::Finders::Passwords::WpLogin.new(target)
        end
      end

      # @return [ Array<Users> ] The users to brute force
      def users
        return target.users unless parsed_options[:usernames]

        parsed_options[:usernames].reduce([]) do |acc, elem|
          acc << CMSScanner::User.new(elem.chomp)
        end
      end

      # @param [ String ] wordlist_path
      #
      # @return [ Array<String> ]
      def passwords(wordlist_path)
        @passwords ||= File.open(wordlist_path).reduce([]) do |acc, elem|
          acc << elem.chomp
        end
      end
    end
  end
end
