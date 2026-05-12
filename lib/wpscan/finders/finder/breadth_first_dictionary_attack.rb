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
        # @option opts [ Integer ] :max_retries Maximum retry attempts for failed requests
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
          max_retries = opts[:max_retries] || 0

          # Calculate total, accounting for skipped passwords
          total_passwords = wordlist.count
          effective_passwords = [total_passwords - skip_count, 0].max

          create_progress_bar(total: users.size * effective_passwords, show_progression: opts[:show_progression])

          queue_count         = 0
          # Keep the number of requests sent for each users
          # to be able to correctly update the progress when a password is found
          user_requests_count = {}
          # Track retry attempts for each user/password combination
          retry_count = Hash.new { |h, k| h[k] = Hash.new(0) }

          users.each { |u| user_requests_count[u.username] = 0 }

          # Show skip progress if skipping
          if skip_count > 0 && opts[:show_progression]
            progress_bar.log("[INFO] Skipping first #{skip_count} password(s) from wordlist...")
          end

          File.foreach(wordlist, chomp: true).lazy.drop(skip_count).each do |password|
            remaining_users = users.select { |u| u.password.nil? }

            break if remaining_users.empty?

            remaining_users.each do |user|
              queue_login_request(user, password, user_requests_count, retry_count, max_retries, effective_passwords, opts) do |found_user|
                yield found_user if block_given?
              end
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

        # Queue a login request with retry support
        #
        # @param [ WPScan::Model::User ] user
        # @param [ String ] password
        # @param [ Hash ] user_requests_count
        # @param [ Hash ] retry_count
        # @param [ Integer ] max_retries
        # @param [ Integer ] effective_passwords Total passwords accounting for skip
        # @param [ Hash ] opts
        #
        # rubocop:disable all
        def queue_login_request(user, password, user_requests_count, retry_count, max_retries, effective_passwords, opts, &block)
          request = login_request(user.username, password)

          user_requests_count[user.username] += 1

          request.on_complete do |res|
            retry_key = "#{user.username}:#{password}"
            current_retry = retry_count[user.username][password]

            progress_bar.title = "Trying #{user.username} / #{password}" +
                                 (current_retry > 0 ? " (retry #{current_retry}/#{max_retries})" : "")

            if valid_credentials?(res)
              # Success - found valid credentials
              progress_bar.increment unless progress_bar.progress == progress_bar.total

              user.password = password

              begin
                progress_bar.total -= effective_passwords - user_requests_count[user.username]
              rescue ProgressBar::InvalidProgressError
              end

              yield user if block_given?
            elsif errored_response?(res)
              # Error response - potentially retryable
              if current_retry < max_retries
                # Retry the request
                retry_count[user.username][password] += 1

                if opts[:show_progression]
                  progress_bar.log("[RETRY #{retry_count[user.username][password]}/#{max_retries}] #{user.username} / #{password}")
                end

                queue_login_request(user, password, user_requests_count, retry_count, max_retries, effective_passwords, opts, &block)
              else
                # Max retries exhausted, log error and move on
                output_error(res)
                progress_bar.increment unless progress_bar.progress == progress_bar.total
              end
            else
              # Invalid credentials (normal case) - just increment progress
              progress_bar.increment unless progress_bar.progress == progress_bar.total
            end
          end

          hydra.queue(request)
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
