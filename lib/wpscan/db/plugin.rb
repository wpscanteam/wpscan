# frozen_string_literal: true

module WPScan
  module DB
    # Plugin DB
    class Plugin < WpItem
      # @return [ Hash ]
      def self.metadata
        @metadata ||= super['plugins'] || {}
      end
    end
  end
end
