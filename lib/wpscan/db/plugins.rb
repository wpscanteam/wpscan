# frozen_string_literal: true

module WPScan
  module DB
    # WP Plugins
    class Plugins < WpItems
      # @return [ JSON ]
      def self.metadata
        Plugin.metadata
      end
    end
  end
end
