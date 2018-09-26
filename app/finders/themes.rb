require_relative 'themes/urls_in_homepage'
require_relative 'themes/known_locations'

module WPScan
  module Finders
    module Themes
      # themes Finder
      class Base
        include CMSScanner::Finders::SameTypeFinder

        # @param [ WPScan::Target ] target
        def initialize(target)
          finders <<
            Themes::UrlsInHomepage.new(target) <<
            Themes::KnownLocations.new(target)
        end
      end
    end
  end
end
