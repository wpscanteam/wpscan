# frozen_string_literal: true

require_relative 'config_backups/known_filenames'

module WPScan
  module Finders
    module ConfigBackups
      # Config Backup Finder
      class Base
        include CMSScanner::Finders::SameTypeFinder

        # @param [ WPScan::Target ] target
        def initialize(target)
          finders << ConfigBackups::KnownFilenames.new(target)
        end
      end
    end
  end
end
