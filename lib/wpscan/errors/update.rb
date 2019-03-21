# frozen_string_literal: true

module WPScan
  module Error
    # Error raised when there is a missing  DB file and --no-update supplied
    class MissingDatabaseFile < Standard
      def to_s
        'Update required, you can not run a scan if a database file is missing.'
      end
    end
  end
end
