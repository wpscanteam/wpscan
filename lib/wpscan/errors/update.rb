# frozen_string_literal: true

module WPScan
  module Error
    # Error raised when there is a missing  DB file and --no-update supplied
    class MissingDatabaseFile < Standard
      def to_s
        'Update required, you can not run a scan if a database file is missing.'
      end
    end

    class ChecksumsMismatch < Standard
      attr_reader :db_file

      def initialize(db_file)
        @db_file = db_file
      end

      def to_s
        "#{db_file}: checksums do not match. Please try again in a few minutes."
      end
    end
  end
end
