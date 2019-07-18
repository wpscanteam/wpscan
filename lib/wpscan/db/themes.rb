# frozen_string_literal: true

module WPScan
  module DB
    # WP Themes
    class Themes < WpItems
      # @return [ JSON ]
      def self.metadata
        Theme.metadata
      end
    end
  end
end
