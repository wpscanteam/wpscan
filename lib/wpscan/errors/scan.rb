# frozen_string_literal: true

module WPScan
  module Error
    # Used instead of the Timeout::Error
    class MaxScanDurationReached < Standard
      # simplecov:disable
      def to_s
        'Max Scan Duration Reached'
      end
      # simplecov:enable
    end
  end
end
