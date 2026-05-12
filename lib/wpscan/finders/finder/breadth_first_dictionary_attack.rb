# frozen_string_literal: true

module WPScan
  module Finders
    class Finder
      # Module to provide an easy way to perform password attacks
      module BreadthFirstDictionaryAttack
        # @param [ Array<WPScan::Model::User> ] users
        # @param [ String ] wordlist_path
        # @param [ Hash ] opts
        # @option opts [ Boolean ] :show_progression
        # @option opts [ Integer ] :wordlist_skip Number of passwords to skip from the beginning
        #
        # @yield [ WPScan::User ] When a valid combination is found
        #
        # Due to Typhoeus threads shenanigans, in rare cases the progress-bar might
        # be incorrectly updated, hence the 'rescue ProgressBar::InvalidProgressError'
        #
        # TODO: Make rubocop happy about metrics etc
        #
        # rubocop:disable all
        def attack(users, wordlist_path, opts = {})
          wordlist = File.open(wordlist_path)
          skip_count = opts[:wordlist_skip] || 0

          # Calculate total, accounting for skipped passwords
          total_passwords = wordlist.count
          effective_passwords = [total_passwords - skip_count, 0].max

          create_progress_bar(total: users.size * effective_passwords, show_progression: opts[:show_progression])

          queue_count         = 0
          # Keep the number of requests sent for each users
          # to be able to correctly update the progress when a password is found
          user_requests_count = {}

          users.each { |u| user_requests_count[u.username] = 0 }

          # Show skip progress if skipping
          if skip_count > 0 && opts[:show_progression]
            progress_bar.log("[INFO] Skipping first #{skip_count} password(s) from wordlist...")
          end

          File.foreach(wordlist, chomp: true).lazy.drop(skip_count).each do |password|
            remaining_users = users.select { |u| u.password.nil? }

            break if remaining_users.empty?

            remaining_users.each do |user|
              request = login_request(user.username, password)

              user_requests_count[user.username] += 1

              request.on_complete do |res|
                progress_bar.title = "Trying #{user.username} / #{password}"

                progress_bar.increment unless progress_bar.progress == progress_bar.total

                if valid_credentials?(res)
                  user.password = password

                  begin
                    progress_bar.total -= effective_passwords - user_requests_count[user.username]
                  rescue ProgressBar::InvalidProgressError
                  end

                  yield user
                elsif errored_response?(res)
                  output_error(res)
                end
              end

              hydra.queue(request)
              queue_count += 1

              if queue_count >= hydra.max_concurrency
                hydra.run
                queue_count = 0
              end
            end
          end

          hydra.run
          progress_bar.stop
        end
        # rubocop:enable all

        # @param [ String ] username
        # param [ String ] password
        #
        # @return [ Typhoeus::Request ]
        def login_request(username, password)
          # To Implement in the finder related to the attack
        end

        # @param [ Typhoeus::Response ] response
        #
        # @return [ Boolean ] Whether or not credentials related to the request are valid
        def valid_credentials?(response)
          # To Implement in the finder related to the attack
        end

        # @param [ Typhoeus::Response ] response
        #
        # @return [ Boolean ] Whether or not something wrong happened
        #                     other than wrong credentials
        def errored_response?(response)
          # To Implement in the finder related to the attack
        end

        protected

        # @param [ Typhoeus::Response ] response
        def output_error(response)
          error = if response.timed_out?
                    'Request timed out.'
                  elsif response.code.zero?
                    "No response from remote server. WAF/IPS? (#{response.return_message})"
                  elsif response.code.to_s.start_with?('50')
                    'Server error, try reducing the number of threads.'
                  elsif WPScan::ParsedCli.verbose?
                    "Unknown response received Code: #{response.code}\nBody: #{response.body}"
                  else
                    "Unknown response received Code: #{response.code}"
                  end

          progress_bar.log("Error: #{error}")
        end
      end
    end
  end
end
