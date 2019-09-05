# frozen_string_literal: true

module WPScan
  module DB
    class Sponsor
      # @return [ Hash ]
      def self.text
        @text ||= file_path.exist? ? File.read(file_path).chomp : ''
      end

      def self.file_path
        @file_path ||= DB_DIR.join('sponsor.txt')
      end
    end
  end
end
