# frozen_string_literal: true

module WPScan
  module Model
    # Robots.txt
    class RobotsTxt < InterestingFinding
      # @return [ String ]
      def to_s
        @to_s ||= "robots.txt found: #{url}"
      end

      # @todo Better detection, currently everything not empty or / is returned
      #
      # @return [ Array<String> ] The interesting Allow/Disallow rules detected
      def interesting_entries
        results = []

        entries.each do |entry|
          next unless entry =~ /\A(?:dis)?allow:\s*(.+)\z/i

          match = Regexp.last_match(1)
          next if match == '/'

          results << match
        end

        results.uniq
      end
    end
  end
end
