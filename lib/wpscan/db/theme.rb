module WPScan
  module DB
    # Theme DB
    class Theme < WpItem
      # @return [ String ]
      def self.db_file
        @db_file ||= File.join(DB_DIR, 'themes.json')
      end
    end
  end
end
