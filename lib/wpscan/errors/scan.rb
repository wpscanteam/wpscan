# frozen_string_literal: true

module WPScan
  module Error
    # Used instead of the Timeout::Error
    class MaxScanDurationReached < Standard
      # :nocov:
      def to_s
        'Max Scan Duration Reached'
      end
      # :nocov:
    end
  end
end
