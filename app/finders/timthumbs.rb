# frozen_string_literal: true

require_relative 'timthumbs/known_locations'

module WPScan
  module Finders
    module Timthumbs
      # Timthumbs Finder
      class Base
        include CMSScanner::Finders::SameTypeFinder

        # @param [ WPScan::Target ] target
        def initialize(target)
          finders << Timthumbs::KnownLocations.new(target)
        end
      end
    end
  end
end
