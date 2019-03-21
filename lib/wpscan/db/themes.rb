# frozen_string_literal: true

module WPScan
  module DB
    # WP Themes
    class Themes < WpItems
      # @return [ JSON ]
      def self.db
        Theme.db
      end
    end
  end
end
