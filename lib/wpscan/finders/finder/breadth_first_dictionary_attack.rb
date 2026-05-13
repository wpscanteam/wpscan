# frozen_string_literal: true

module WPScan
  module Finders
    class Finder
      # Module to provide an easy way to perform password attacks
      module BreadthFirstDictionaryAttack
        # Tracks progress for password attack
        class ProgressTracker
          attr_reader :progress_bar

          def initialize(progress_bar:, total_passwords:)
            @progress_bar = progress_bar
            @total_passwords = total_passwords
            @user_requests_count = Hash.new(0)
          end

          def record_request(username)
            @user_requests_count[username] += 1
          end

          def requests_for_user(username)
            @user_requests_count[username]
          end

          def update_title(username, password, retry_count, max_retries)
            retry_info = retry_count.positive? ? " (retry #{retry_count}/#{max_retries})" : ''
            @progress_bar.title = "Trying #{username} / #{password}#{retry_info}"
          end

          def increment
            @progress_bar.increment unless @progress_bar.progress == @progress_bar.total
          end

          def adjust_total_on_success(username)
            @progress_bar.total -= @total_passwords - @user_requests_count[username]
          rescue ProgressBar::InvalidProgressError
            # Due to Typhoeus threads, progress bar might be in invalid state
          end

          def log(message)
            @progress_bar.log(message)
          end

          def stop
            @progress_bar.stop
          end
        end

        # Configuration bundle for LoginAttempt
        LoginConfig = Struct.new(:tracker, :request_builder, :credentials_validator,
                                 :error_checker, :error_handler, :hydra, :opts,
                                 keyword_init: true)

        # Handles a single login attempt with retry support
        class LoginAttempt
          attr_reader :user, :password, :max_retries
          attr_accessor :retry_count

          def initialize(user:, password:, max_retries:, config:)
            @user = user
            @password = password
            @max_retries = max_retries
            @retry_count = 0
            @config = config
          end

          def execute(&block)
            request = @config.request_builder.call(@user.username, @password)
            @config.tracker.record_request(@user.username) if @retry_count.zero?

            request.on_complete do |response|
              handle_response(response, &block)
            end

            @config.hydra.queue(request)
          end

          private

          def handle_response(response, &)
            @config.tracker.update_title(@user.username, @password, @retry_count, @max_retries)

            if @config.credentials_validator.call(response)
              handle_success(&)
            elsif @config.error_checker.call(response)
              handle_error(response, &)
            else
              handle_invalid_credentials
            end
          end

          def handle_success
            @config.tracker.increment
            @user.password = @password
            @config.tracker.adjust_total_on_success(@user.username)

            yield @user if block_given?
          end

          def handle_error(response, &)
            if @user.password
              @config.tracker.increment
              return
            end

            if should_retry?
              retry_attempt(&)
            else
              finalize_failed_attempt(response)
            end
          end

          def should_retry?
            @retry_count < @max_retries
          end

          def retry_attempt(&)
            @retry_count += 1

            if @config.opts[:show_progression] && WPScan::ParsedCli.verbose?
              @config.tracker.log("[RETRY #{@retry_count}/#{@max_retries}] #{@user.username} / #{@password}")
            end

            execute(&)
          end

          def finalize_failed_attempt(response)
            @config.error_handler.call(response)
            @config.tracker.increment
          end

          def handle_invalid_credentials
            @config.tracker.increment
          end
        end

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
          tracker = ProgressTracker.new(progress_bar: progress_bar, total_passwords: effective_passwords)
          config = create_login_config(tracker, opts)

          # Show skip progress if skipping
          if skip_count.positive? && opts[:show_progression]
            tracker.log("[INFO] Skipping first #{skip_count} password(s) from wordlist...")
          end

          queue_count = 0

          File.foreach(wordlist, chomp: true).lazy.drop(skip_count).each do |password|
            remaining_users = users.select { |u| u.password.nil? }
            break if remaining_users.empty?

            remaining_users.each do |user|
              attempt = LoginAttempt.new(user: user, password: password, max_retries: max_retries, config: config)
              attempt.execute { |found_user| yield found_user if block_given? }
              queue_count += 1

              if queue_count >= hydra.max_concurrency
                hydra.run
                queue_count = 0
              end
            end
          end

          hydra.run
          tracker.stop
        end
        # rubocop:enable all

        # Create login configuration with all dependencies
        #
        # @param [ ProgressTracker ] tracker
        # @param [ Hash ] opts
        #
        # @return [ LoginConfig ]
        #
        def create_login_config(tracker, opts)
          LoginConfig.new(
            tracker: tracker,
            request_builder: method(:login_request).to_proc,
            credentials_validator: method(:valid_credentials?).to_proc,
            error_checker: method(:errored_response?).to_proc,
            error_handler: method(:output_error).to_proc,
            hydra: hydra,
            opts: opts
          )
        end

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
