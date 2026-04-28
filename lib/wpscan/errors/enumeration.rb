# frozen_string_literal: true

module WPScan
  module Error
    class PluginsThresholdReached < Standard
      def to_s
        "The number of plugins detected reached the threshold of #{ParsedCli.plugins_threshold} " \
          'which might indicate False Positive. You can use --plugins-threshold to increase or disable ' \
          'this limit (set to 0 to disable), or use --exclude-content-based to ignore bad responses.'
      end
    end

    class ThemesThresholdReached < Standard
      def to_s
        "The number of themes detected reached the threshold of #{ParsedCli.themes_threshold} " \
          'which might indicate False Positive. You can use --themes-threshold to increase or disable ' \
          'this limit (set to 0 to disable), or use --exclude-content-based to ignore bad responses.'
      end
    end
  end
end
