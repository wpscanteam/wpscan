# frozen_string_literal: true

module WPScan
  module Model
    # Custom class to include the WPScan::References module
    class InterestingFinding < CMSScanner::Model::InterestingFinding
      include References
    end

    #
    # Empty classes for the #type to be correctly displayed (as taken from the self.class from the parent)
    #
    class BackupDB < InterestingFinding
    end

    class DebugLog < InterestingFinding
    end

    class DuplicatorInstallerLog < InterestingFinding
    end

    class EmergencyPwdResetScript < InterestingFinding
    end

    class FullPathDisclosure < InterestingFinding
    end

    class MuPlugins < InterestingFinding
    end

    class Multisite < InterestingFinding
    end

    class Readme < InterestingFinding
    end

    class Registration < InterestingFinding
    end

    class TmmDbMigrate < InterestingFinding
    end

    class UploadDirectoryListing < InterestingFinding
    end

    class UploadSQLDump < InterestingFinding
    end

    class WPCron < InterestingFinding
    end
  end
end
