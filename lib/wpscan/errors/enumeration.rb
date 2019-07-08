# frozen_string_literal: true

module WPScan
  module Error
    class PluginsThresholdReached < Standard
      def to_s
        "The number of plugins detected reached the threshold of #{ParsedCli.plugins_threshold} " \
        'which might indicate False Positive. It would be recommended to use the --exclude-content-based ' \
        'option to ignore the bad responses.'
      end
    end

    class ThemesThresholdReached < Standard
      def to_s
        "The number of themes detected reached the threshold of #{ParsedCli.themes_threshold} " \
        'which might indicate False Positive. It would be recommended to use the --exclude-content-based ' \
        'option to ignore the bad responses.'
      end
    end
  end
end
