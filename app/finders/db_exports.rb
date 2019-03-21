# frozen_string_literal: true

require_relative 'db_exports/known_locations'

module WPScan
  module Finders
    module DbExports
      # DB Exports Finder
      class Base
        include CMSScanner::Finders::SameTypeFinder

        # @param [ WPScan::Target ] target
        def initialize(target)
          finders << DbExports::KnownLocations.new(target)
        end
      end
    end
  end
end
