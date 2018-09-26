module WPScan
  module DB
    # WP Plugins
    class Plugins < WpItems
      # @return [ JSON ]
      def self.db
        Plugin.db
      end
    end
  end
end
