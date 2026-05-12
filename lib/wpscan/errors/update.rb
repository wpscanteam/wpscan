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
      attr_reader :db_file, :cf_ray

      def initialize(db_file, cf_ray: nil)
        @db_file = db_file
        @cf_ray  = cf_ray
        super()
      end

      def to_s
        msg = "#{db_file}: checksums do not match. Please try again in a few minutes."
        msg += "\nCloudflare Ray ID: #{cf_ray}" if cf_ray
        msg += "\nIf this issue persists, you can:\n  " \
               "- Check our status page at https://status.wpscan.com/\n  " \
               "- Contact us via https://wpscan.com/contact/ (please include the Ray ID above if any)\n  " \
               '- Or open a GitHub issue at https://github.com/wpscanteam/wpscan/issues'
        msg
      end
    end
  end
end
