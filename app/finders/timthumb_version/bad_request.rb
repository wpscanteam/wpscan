# frozen_string_literal: true

module WPScan
  module Finders
    module TimthumbVersion
      # Timthumb Version Finder from the body of a bad request
      # See https://code.google.com/p/timthumb/source/browse/trunk/timthumb.php#435
      class BadRequest < CMSScanner::Finders::Finder
        # @return [ Version ]
        def aggressive(_opts = {})
          return unless Browser.get(target.url).body =~ /(TimThumb version\s*: ([^<]+))/

          Model::Version.new(
            Regexp.last_match[2],
            found_by: 'Bad Request (Aggressive Detection)',
            confidence: 90,
            interesting_entries: ["#{target.url}, Match: '#{Regexp.last_match[1]}'"]
          )
        end
      end
    end
  end
end
