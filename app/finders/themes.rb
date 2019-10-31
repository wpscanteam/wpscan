# frozen_string_literal: true

require_relative 'themes/urls_in_homepage'
require_relative 'themes/urls_in_404_page'
require_relative 'themes/known_locations'

module WPScan
  module Finders
    module Themes
      # Themes Finder
      class Base
        include CMSScanner::Finders::SameTypeFinder

        # @param [ WPScan::Target ] target
        def initialize(target)
          finders <<
            Themes::UrlsInHomepage.new(target) <<
            Themes::UrlsIn404Page.new(target) <<
            Themes::KnownLocations.new(target)
        end
      end
    end
  end
end
