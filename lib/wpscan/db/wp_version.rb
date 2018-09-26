module WPScan
  module DB
    # WP Version
    class Version < WpItem
      # @return [ String ]
      def self.db_file
        @db_file ||= File.join(DB_DIR, 'wordpresses.json')
      end
    end
  end
end
