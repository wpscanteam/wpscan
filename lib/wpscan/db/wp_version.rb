module WPScan
  module DB
    # WP Version
    class Version < WpItem
      # @return [ String ]
      def self.db_file
        @db_file ||= DB_DIR.join('wordpresses.json')
      end
    end
  end
end
