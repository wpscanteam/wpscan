module WPScan
  module DB
    # Plugin DB
    class Plugin < WpItem
      # @return [ String ]
      def self.db_file
        @db_file ||= DB_DIR.join('plugins.json')
      end
    end
  end
end
