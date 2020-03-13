# frozen_string_literal: true

module WPScan
  module Model
    # Custom class to include the WPScan::References module
    class InterestingFinding < CMSScanner::Model::InterestingFinding
      include References
    end

    #
    # Some classes are empty for the #type to be correctly displayed (as taken from the self.class from the parent)
    #
    class BackupDB < InterestingFinding
      # @return [ Hash ]
      def references
        @references ||= { url: ['https://github.com/wpscanteam/wpscan/issues/422'] }
      end
    end

    class DebugLog < InterestingFinding
      # @ return [ Hash ]
      def references
        @references ||= { url: ['https://codex.wordpress.org/Debugging_in_WordPress'] }
      end
    end

    class DuplicatorInstallerLog < InterestingFinding
      # @return [ Hash ]
      def references
        @references ||= { url: ['https://www.exploit-db.com/ghdb/3981/'] }
      end
    end

    class EmergencyPwdResetScript < InterestingFinding
      def references
        @references ||= {
          url: ['https://codex.wordpress.org/Resetting_Your_Password#Using_the_Emergency_Password_Reset_Script']
        }
      end
    end

    class FullPathDisclosure < InterestingFinding
      # @return [ Hash ]
      def references
        @references ||= { url: ['https://www.owasp.org/index.php/Full_Path_Disclosure'] }
      end
    end

    class MuPlugins < InterestingFinding
      # @return [ String ]
      def to_s
        @to_s ||= "This site has 'Must Use Plugins': #{url}"
      end

      # @return [ Hash ]
      def references
        @references ||= { url: ['http://codex.wordpress.org/Must_Use_Plugins'] }
      end
    end

    class Multisite < InterestingFinding
      # @return [ String ]
      def to_s
        @to_s ||= 'This site seems to be a multisite'
      end

      # @return [ Hash ]
      def references
        @references ||= { url: ['http://codex.wordpress.org/Glossary#Multisite'] }
      end
    end

    class Readme < InterestingFinding
    end

    class Registration < InterestingFinding
      # @return [ String ]
      def to_s
        @to_s ||= "Registration is enabled: #{url}"
      end
    end

    class TmmDbMigrate < InterestingFinding
      # @return [ Hash ]
      def references
        @references ||= { packetstorm: [131_957] }
      end
    end

    class UploadDirectoryListing < InterestingFinding
      # @return [ String ]
      def to_s
        @to_s ||= "Upload directory has listing enabled: #{url}"
      end
    end

    class UploadSQLDump < InterestingFinding
    end

    class WPCron < InterestingFinding
      # @return [ String ]
      def to_s
        @to_s ||= "The external WP-Cron seems to be enabled: #{url}"
      end

      # @return [ Hash ]
      def references
        @references ||= {
          url: [
            'https://www.iplocation.net/defend-wordpress-from-ddos',
            'https://github.com/wpscanteam/wpscan/issues/1299'
          ]
        }
      end
    end
  end
end
