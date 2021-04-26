# frozen_string_literal: true

module WPScan
  module Controller
    # Enumeration CLI Options
    class Enumeration < CMSScanner::Controller::Base
      def cli_options
        cli_enum_choices + cli_plugins_opts + cli_themes_opts +
          cli_timthumbs_opts + cli_config_backups_opts + cli_db_exports_opts +
          cli_medias_opts + cli_users_opts
      end

      # @return [ Array<OptParseValidator::OptBase> ]
      def cli_enum_choices
        [
          OptMultiChoices.new(
            ['-e', '--enumerate [OPTS]', 'Enumeration Process'],
            choices: {
              vp: OptBoolean.new(['--vulnerable-plugins']),
              ap: OptBoolean.new(['--all-plugins']),
              p: OptBoolean.new(['--popular-plugins']),
              vt: OptBoolean.new(['--vulnerable-themes']),
              at: OptBoolean.new(['--all-themes']),
              t: OptBoolean.new(['--popular-themes']),
              tt: OptBoolean.new(['--timthumbs']),
              cb: OptBoolean.new(['--config-backups']),
              dbe: OptBoolean.new(['--db-exports']),
              u: OptIntegerRange.new(['--users', 'User IDs range. e.g: u1-5'], value_if_empty: '1-10'),
              m: OptIntegerRange.new(['--medias',
                                      'Media IDs range. e.g m1-15',
                                      'Note: Permalink setting must be set to "Plain" for those to be detected'],
                                     value_if_empty: '1-100')
            },
            value_if_empty: 'vp,vt,tt,cb,dbe,u,m',
            incompatible: [%i[vp ap p], %i[vt at t]]
          ),
          OptRegexp.new(
            [
              '--exclude-content-based REGEXP_OR_STRING',
              'Exclude all responses matching the Regexp (case insensitive) during parts of the enumeration.',
              'Both the headers and body are checked. Regexp delimiters are not required.'
            ], options: Regexp::IGNORECASE
          )
        ]
      end

      # @return [ Array<OptParseValidator::OptBase> ]
      def cli_plugins_opts
        [
          OptSmartList.new(['--plugins-list LIST', 'List of plugins to enumerate'], advanced: true),
          OptChoice.new(
            ['--plugins-detection MODE',
             'Use the supplied mode to enumerate Plugins.'],
            choices: %w[mixed passive aggressive], normalize: :to_sym
          ),
          OptBoolean.new(
            ['--plugins-version-all',
             'Check all the plugins version locations according to the choosen mode (--detection-mode, ' \
             '--plugins-detection and --plugins-version-detection)'],
            advanced: true
          ),
          OptChoice.new(
            ['--plugins-version-detection MODE',
             'Use the supplied mode to check plugins\' versions.'],
            choices: %w[mixed passive aggressive], normalize: :to_sym
          ),
          OptInteger.new(
            ['--plugins-threshold THRESHOLD',
             'Raise an error when the number of detected plugins via known locations reaches the threshold. ' \
             'Set to 0 to ignore the threshold.'], default: 100, advanced: true
          )
        ]
      end

      # @return [ Array<OptParseValidator::OptBase> ]
      def cli_themes_opts
        [
          OptSmartList.new(['--themes-list LIST', 'List of themes to enumerate'], advanced: true),
          OptChoice.new(
            ['--themes-detection MODE',
             'Use the supplied mode to enumerate Themes, instead of the global (--detection-mode) mode.'],
            choices: %w[mixed passive aggressive], normalize: :to_sym, advanced: true
          ),
          OptBoolean.new(
            ['--themes-version-all',
             'Check all the themes version locations according to the choosen mode (--detection-mode, ' \
             '--themes-detection and --themes-version-detection)'],
            advanced: true
          ),
          OptChoice.new(
            ['--themes-version-detection MODE',
             'Use the supplied mode to check themes versions instead of the --detection-mode ' \
             'or --themes-detection modes.'],
            choices: %w[mixed passive aggressive], normalize: :to_sym, advanced: true
          ),
          OptInteger.new(
            ['--themes-threshold THRESHOLD',
             'Raise an error when the number of detected themes via known locations reaches the threshold. ' \
             'Set to 0 to ignore the threshold.'], default: 20, advanced: true
          )
        ]
      end

      # @return [ Array<OptParseValidator::OptBase> ]
      def cli_timthumbs_opts
        [
          OptFilePath.new(
            ['--timthumbs-list FILE-PATH', 'List of timthumbs\' location to use'],
            exists: true, default: DB_DIR.join('timthumbs-v3.txt').to_s, advanced: true
          ),
          OptChoice.new(
            ['--timthumbs-detection MODE',
             'Use the supplied mode to enumerate Timthumbs, instead of the global (--detection-mode) mode.'],
            choices: %w[mixed passive aggressive], normalize: :to_sym, advanced: true
          )
        ]
      end

      # @return [ Array<OptParseValidator::OptBase> ]
      def cli_config_backups_opts
        [
          OptFilePath.new(
            ['--config-backups-list FILE-PATH', 'List of config backups\' filenames to use'],
            exists: true, default: DB_DIR.join('config_backups.txt').to_s, advanced: true
          ),
          OptChoice.new(
            ['--config-backups-detection MODE',
             'Use the supplied mode to enumerate Config Backups, instead of the global (--detection-mode) mode.'],
            choices: %w[mixed passive aggressive], normalize: :to_sym, advanced: true
          )
        ]
      end

      # @return [ Array<OptParseValidator::OptBase> ]
      def cli_db_exports_opts
        [
          OptFilePath.new(
            ['--db-exports-list FILE-PATH', 'List of DB exports\' paths to use'],
            exists: true, default: DB_DIR.join('db_exports.txt').to_s, advanced: true
          ),
          OptChoice.new(
            ['--db-exports-detection MODE',
             'Use the supplied mode to enumerate DB Exports, instead of the global (--detection-mode) mode.'],
            choices: %w[mixed passive aggressive], normalize: :to_sym, advanced: true
          )
        ]
      end

      # @return [ Array<OptParseValidator::OptBase> ]
      def cli_medias_opts
        [
          OptChoice.new(
            ['--medias-detection MODE',
             'Use the supplied mode to enumerate Medias, instead of the global (--detection-mode) mode.'],
            choices: %w[mixed passive aggressive], normalize: :to_sym, advanced: true
          )
        ]
      end

      # @return [ Array<OptParseValidator::OptBase> ]
      def cli_users_opts
        [
          OptSmartList.new(
            ['--users-list LIST',
             'List of users to check during the users enumeration from the Login Error Messages'],
            advanced: true
          ),
          OptChoice.new(
            ['--users-detection MODE',
             'Use the supplied mode to enumerate Users, instead of the global (--detection-mode) mode.'],
            choices: %w[mixed passive aggressive], normalize: :to_sym, advanced: true
          ),
          OptRegexp.new(
            [
              '--exclude-usernames REGEXP_OR_STRING',
              'Exclude usernames matching the Regexp/string (case insensitive). Regexp delimiters are not required.'
            ], options: Regexp::IGNORECASE
          )
        ]
      end
    end
  end
end
