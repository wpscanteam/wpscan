# frozen_string_literal: true

module WPScan
  module Model
    # Fantastico is a commercial script library that automates the installation of web applications to a website.
    # Fantastico scripts are executed from the administration area of a website control panel such as cPanel.
    # It creates a file named fantastico_fileslist.txt that is publicly available and contains a list of all the
    # files from the current directory. The contents of this file may expose sensitive information to an attacker.
    class FantasticoFileslist < InterestingFinding
      # @return [ String ]
      def to_s
        @to_s ||= "Fantastico list found: #{url}"
      end

      # @return [ Array<String> ] The interesting files/dirs detected
      def interesting_entries
        results = []

        entries.each do |entry|
          next unless /(?:admin|\.log|\.sql|\.db)/i.match?(entry)

          results << entry
        end
        results
      end

      def references
        @references ||= {
          url: ['https://web.archive.org/web/20140518040021/http://www.acunetix.com/vulnerabilities/fantastico-fileslist/']
        }
      end
    end
  end
end
