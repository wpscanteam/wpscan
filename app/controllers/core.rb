# frozen_string_literal: true

module WPScan
  module Controller
    # Specific Core controller to include WordPress checks
    class Core < CMSScanner::Controller::Core
      # @return [ Array<OptParseValidator::Opt> ]
      def cli_options
        [OptURL.new(['--url URL', 'The URL of the blog to scan'],
                    required_unless: %i[update help hh version], default_protocol: 'http')] +
          super.drop(2) + # delete the --url and --force from CMSScanner
          [
            OptChoice.new(['--server SERVER', 'Force the supplied server module to be loaded'],
                          choices: %w[apache iis nginx],
                          normalize: %i[downcase to_sym],
                          advanced: true),
            OptBoolean.new(['--force', 'Do not check if the target is running WordPress or returns a 403']),
            OptBoolean.new(['--[no-]update', 'Whether or not to update the Database'])
          ]
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

        /^y/i.match?(Readline.readline)
      end

      def update_db
        output('db_update_started')
        output('db_update_finished', updated: local_db.update, verbose: ParsedCli.verbose)

        exit(0) unless ParsedCli.url
      end

      def before_scan
        @last_update = local_db.last_update

        maybe_output_banner_help_and_version # From CMSScanner

        update_db if update_db_required?
        setup_cache
        check_target_availability
        load_server_module
        check_wordpress_state
      rescue Error::NotWordPress => e
        target.maybe_add_cookies
        raise e unless target.wordpress?(ParsedCli.detection_mode)
      end

      # Raises errors if the target is hosted on wordpress.com or is not running WordPress
      # Also check if the homepage_url is still the install url
      def check_wordpress_state
        raise Error::WordPressHosted if target.wordpress_hosted?

        if %r{/wp-admin/install.php$}i.match?(Addressable::URI.parse(target.homepage_url).path)

          output('not_fully_configured', url: target.homepage_url)

          exit(WPScan::ExitCode::VULNERABLE)
        end

        raise Error::NotWordPress unless target.wordpress?(ParsedCli.detection_mode) || ParsedCli.force
      end

      # Loads the related server module in the target
      # and includes it in the WpItem class which will be needed
      # to check if directory listing is enabled etc
      #
      # @return [ Symbol ] The server module loaded
      def load_server_module
        server = target.server || :Apache # Tries to auto detect the server

        # Force a specific server module to be loaded if supplied
        case ParsedCli.server
        when :apache
          server = :Apache
        when :iis
          server = :IIS
        when :nginx
          server = :Nginx
        end

        mod = CMSScanner::Target::Server.const_get(server)

        target.extend mod
        Model::WpItem.include mod

        server
      end
    end
  end
end
