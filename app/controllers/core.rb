# frozen_string_literal: true

require_relative 'core/cli_options'
require 'socket'
require 'English'

module WPScan
  module Controller
    # Core Controller (WordPress-aware).
    class Core < Base
      # @return [ Array<OptParseValidator::Opt> ]
      def cli_options
        [OptURL.new(['--url URL', 'The URL of the blog to scan'],
                    required_unless: %i[update help hh version], default_protocol: 'http')] +
          base_cli_options.drop(2) + # drop the base --url and --force
          [
            OptChoice.new(['--server SERVER', 'Force the supplied server module to be loaded'],
                          choices: %w[apache iis nginx],
                          normalize: %i[downcase to_sym],
                          advanced: true),
            OptBoolean.new(['--force', 'Do not check if the target is running WordPress or returns a 403']),
            OptBoolean.new(['--[no-]update', 'Whether or not to update the Database'])
          ]
      end

      def setup_cache
        return unless WPScan::ParsedCli.cache_dir

        storage_path = File.join(WPScan::ParsedCli.cache_dir, Digest::MD5.hexdigest(target.url))

        Typhoeus::Config.cache = Cache::Typhoeus.new(storage_path)
        Typhoeus::Config.cache.clean if WPScan::ParsedCli.clear_cache
      end

      def before_scan
        @last_update = local_db.last_update

        maybe_output_banner_help_and_version

        update_db if update_db_required?
        setup_cache
        check_target_availability
        load_server_module
        check_wordpress_state
      rescue Error::NotWordPress => e
        target.maybe_add_cookies
        raise e unless target.wordpress?(ParsedCli.detection_mode)
      end

      def maybe_output_banner_help_and_version
        output('banner') if WPScan::ParsedCli.banner
        output('help', help: option_parser.simple_help, simple: true) if WPScan::ParsedCli.help
        output('help', help: option_parser.full_help, simple: false) if WPScan::ParsedCli.hh
        output('version') if WPScan::ParsedCli.version

        exit(WPScan::ExitCode::OK) if WPScan::ParsedCli.help || WPScan::ParsedCli.hh || WPScan::ParsedCli.version
      end

      # Checks that the target is accessible, raises related errors otherwise.
      #
      # @return [ Void ]
      def check_target_availability
        res = WPScan::Browser.get(target.url)

        case res.code
        when 0
          raise Error::TargetDown, res
        when 401
          raise Error::HTTPAuthRequired
        when 403
          raise Error::AccessForbidden, WPScan::ParsedCli.random_user_agent unless WPScan::ParsedCli.force
        when 407
          raise Error::ProxyAuthRequired
        end

        handle_redirection(res)
      end

      # Checks if the effective_uri contains a SAMLRequest
      #
      # @param [ Addressable::URI ] effective_uri
      #
      # @return [ Boolean ]
      def saml_request?(effective_uri)
        return false unless effective_uri

        # Check the final effective URI for SAMLRequest
        return true if effective_uri.to_s.match?(/[?&]SAMLRequest/i)

        # Check the redirect chain for SAMLRequest in Location headers
        # This catches SAML flows that redirect through intermediate pages
        # Only check if homepage_res has already been loaded (avoid triggering HTTP request)
        if target.instance_variable_defined?(:@homepage_res) && target.instance_variable_get(:@homepage_res)
          target.homepage_res.redirections&.each do |redirect_response|
            headers = redirect_response.response_headers
            next unless headers

            # Extract Location header and check for SAMLRequest
            location = headers[/^Location:\s*(.+?)$/mi, 1]
            return true if location&.match?(/SAMLRequest/i)
          end
        end

        false
      end

      # Handle redirect if the target contains 'SAMLRequest', indicating a need for SAML authentication.
      #
      # @param [ Addressable::URI ] effective_uri
      # @raise [ Error::SAMLAuthenticationRequired ] If the effective_uri contains 'SAMLRequest'
      #
      # @return [ Void ]
      def handle_saml_authentication(effective_uri)
        # If we ended up here, the cookie_string is set, and no --expect-saml flag was included
        raise Error::SAMLAuthenticationFailed if WPScan::ParsedCli.cookie_string && !WPScan::ParsedCli.expect_saml
        # If we ended up here but no --expect-saml flag was included
        raise Error::SAMLAuthenticationRequired unless WPScan::ParsedCli.expect_saml

        # Authenticate using the ferrum browser
        cookie_string = BrowserAuthenticator.authenticate(effective_uri.to_s)

        target_url = target.url # Needed for overriding in tests

        # Restart the scan with the cookies set and pass in the original options filtered
        filtered_opts = build_filtered_options
        command = "wpscan --url #{target_url} --cookie-string '#{cookie_string}' --no-banner #{filtered_opts}"
        Kernel.system(command)

        # Check if the rescan succeeded (exit code 0 = OK, 5 = VULNERABLE are both acceptable)
        # Any other exit code indicates a real failure
        exit_status = $CHILD_STATUS.exitstatus
        acceptable_exit_codes = [WPScan::ExitCode::OK, WPScan::ExitCode::VULNERABLE]
        raise Error::AuthenticatedRescanFailure, command unless acceptable_exit_codes.include?(exit_status)

        exit(exit_status)
      end

      # Builds filtered command-line options from original ARGV, excluding flags that will be re-added
      # Uses original unmasked ARGV captured before option parsing to preserve only user-provided options
      #
      # @return [ String ] Filtered options as a space-separated string
      def build_filtered_options
        options = []
        excluded_flags = %w[--url --cookie-string --expect-saml --banner --no-banner]
        flags_with_values = %w[--url --cookie-string]
        skip_next = false

        WPScan.original_argv.each do |arg|
          # Skip if this is a value that follows an excluded flag
          if skip_next
            skip_next = false
            next
          end

          # Check if this argument is an excluded flag
          if excluded_flags.any? { |flag| arg == flag || arg.start_with?("#{flag}=") }
            # If it's in --flag value format (not --flag=value), skip the next arg too
            skip_next = true if flags_with_values.include?(arg)
            next
          end

          options << arg
        end

        options.join(' ')
      end

      # Checks for redirects; an out-of-scope redirect raises Error::HTTPRedirect.
      #
      # @param [ Typhoeus::Response ] res
      def handle_redirection(res)
        effective_url = target.homepage_res.effective_url # get and follow location of target.url
        effective_uri = Addressable::URI.parse(effective_url)

        # Check for SAML and handle if present
        if WPScan::ParsedCli.expect_saml && !saml_request?(effective_uri)
          puts 'SAML authentication was expected but not required.'
          puts # New line to serve as buffer before the scan results start
        end

        handle_saml_authentication(effective_uri) if saml_request?(effective_uri)

        handle_scheme_redirect(effective_url, effective_uri)
        handle_follow_redirect(effective_url, effective_uri)

        return if target.in_scope?(effective_url)

        raise Error::HTTPRedirect, effective_url unless WPScan::ParsedCli.ignore_main_redirect

        # Sets homepage_res back to unfollowed response when ignore_main_redirect is used
        target.homepage_res = res
      end

      # Handles scheme-only redirects (http => https or vice versa)
      #
      # @param [ String ] effective_url
      # @param [ Addressable::URI ] effective_uri
      def handle_scheme_redirect(effective_url, effective_uri)
        # http://a.com => https://a.com (or the opposite)
        if !WPScan::ParsedCli.ignore_main_redirect && target.uri.domain == effective_uri.domain &&
           target.uri.path == effective_uri.path && target.uri.scheme != effective_uri.scheme

          target.url = effective_url
        end
      end

      # Handles --follow-redirect option
      #
      # @param [ String ] effective_url
      # @param [ Addressable::URI ] effective_uri
      def handle_follow_redirect(effective_url, effective_uri)
        return unless WPScan::ParsedCli.follow_redirect && target.url != effective_url

        target.url = effective_url
        target.scope << effective_uri.host
      end

      # @return [ DB::Updater ]
      def local_db
        @local_db ||= DB::Updater.new(DB_DIR)
      end

      # @return [ Boolean ]
      def update_db_required?
        if local_db.missing_files?
          raise Error::MissingDatabaseFile if ParsedCli.update == false

          return true
        end

        return ParsedCli.update unless ParsedCli.update.nil?

        return false unless user_interaction? && local_db.outdated?

        output('@notice', msg: 'It seems like you have not updated the database for some time.')
        print '[?] Do you want to update now? [Y]es [N]o, default: [N]'
        $stdout.flush

        response = $stdin.gets.to_s.strip

        !!/^y/i.match?(response)
      end

      def update_db
        @updating_db = true
        output('db_update_started')
        output('db_update_finished', updated: local_db.update, verbose: ParsedCli.verbose)
        @updating_db = false

        exit(0) unless ParsedCli.url
      end

      # @return [ Boolean ] Whether the DB update is currently in progress
      def updating_db?
        @updating_db
      end

      # Raises errors if the target is hosted on wordpress.com or is not running WordPress.
      # Also checks if the homepage_url is still the install URL.
      def check_wordpress_state
        raise Error::WordPressHosted if target.wordpress_hosted?

        if %r{/wp-admin/install.php$}i.match?(Addressable::URI.parse(target.homepage_url).path)

          output('not_fully_configured', url: target.homepage_url)

          exit(WPScan::ExitCode::VULNERABLE)
        end

        raise Error::NotWordPress unless target.wordpress?(ParsedCli.detection_mode) || ParsedCli.force
      end

      # Loads the related server module into the target and includes it on WpItem
      # (needed to check if directory listing is enabled etc.).
      #
      # @return [ Symbol ] The server module loaded
      def load_server_module
        server = target.server || :Apache # auto-detect

        case ParsedCli.server
        when :apache
          server = :Apache
        when :iis
          server = :IIS
        when :nginx
          server = :Nginx
        end

        mod = WPScan::Target::Server.const_get(server)

        target.extend mod
        Model::WpItem.include mod

        server
      end

      def run
        @start_time   = Time.now
        @start_memory = WPScan.start_memory

        output('started',
               url: target.url,
               ip: target.ip,
               effective_url: target.homepage_url,
               command_line: WPScan.command_line,
               hostname: Socket.gethostname)
      end

      def after_scan
        @stop_time   = Time.now
        @elapsed     = @stop_time - @start_time
        @used_memory = GetProcessMem.new.bytes - @start_memory

        warnings = WPScan.error_warning_messages

        output('finished',
               cached_requests: WPScan.cached_requests,
               requests_done: WPScan.total_requests,
               data_sent: WPScan.total_data_sent,
               data_received: WPScan.total_data_received,
               response_status_codes: WPScan.format_status_codes(WPScan.top_status_codes),
               response_status_codes_warning: warnings.any?,
               response_status_codes_warnings: warnings)
      end
    end
  end
end
