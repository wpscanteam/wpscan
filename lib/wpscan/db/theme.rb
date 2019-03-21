# frozen_string_literal: true

module WPScan
  module DB
    # Theme DB
    class Theme < WpItem
      # @return [ String ]
      def self.db_file
        @db_file ||= DB_DIR.join('themes.json').to_s
      end
    end
  end
end
