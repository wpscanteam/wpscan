# frozen_string_literal: true

require_relative 'interesting_findings/readme'
require_relative 'interesting_findings/wp_cron'
require_relative 'interesting_findings/multisite'
require_relative 'interesting_findings/debug_log'
require_relative 'interesting_findings/backup_db'
require_relative 'interesting_findings/mu_plugins'
require_relative 'interesting_findings/php_disabled'
require_relative 'interesting_findings/registration'
require_relative 'interesting_findings/tmm_db_migrate'
require_relative 'interesting_findings/upload_sql_dump'
require_relative 'interesting_findings/full_path_disclosure'
require_relative 'interesting_findings/duplicator_installer_log'
require_relative 'interesting_findings/upload_directory_listing'
require_relative 'interesting_findings/emergency_pwd_reset_script'

module WPScan
  module Finders
    module InterestingFindings
      # Interesting Files Finder
      class Base < CMSScanner::Finders::InterestingFindings::Base
        # @param [ WPScan::Target ] target
        def initialize(target)
          super(target)

          %w[
            Readme DebugLog FullPathDisclosure BackupDB DuplicatorInstallerLog
            Multisite MuPlugins Registration UploadDirectoryListing TmmDbMigrate
            UploadSQLDump EmergencyPwdResetScript WPCron PHPDisabled
          ].each do |f|
            finders << InterestingFindings.const_get(f).new(target)
          end
        end
      end
    end
  end
end
