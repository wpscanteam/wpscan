# frozen_string_literal: true

module WPScan
  module Finders
    module WpVersion
      # Readme Version Finder
      class Readme < CMSScanner::Finders::Finder
        # @return [ WpVersion ]
        def aggressive(_opts = {})
          readme_url = target.url('readme.html') # Maybe move this into the Target ?

          node = Browser.get(readme_url).html.css('h1#logo').last

          return unless node&.text.to_s.strip =~ /\AVersion (.*)\z/i

          number = Regexp.last_match(1)

          return unless Model::WpVersion.valid?(number)

          Model::WpVersion.new(
            number,
            found_by: 'Readme (Aggressive Detection)',
            # Since WP 4.7, the Readme only contains the major version (ie 4.7, 4.8 etc)
            confidence: number >= '4.7' ? 10 : 90,
            interesting_entries: ["#{readme_url}, Match: '#{node.text.to_s.strip}'"]
          )
        end
      end
    end
  end
end
