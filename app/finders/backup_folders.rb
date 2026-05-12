# frozen_string_literal: true

require_relative 'backup_folders/known_locations'

module WPScan
  module Finders
    module BackupFolders
      # Backup Folders Finder
      class Base
        include SameTypeFinder

        # @param [ WPScan::Target ] target
        def initialize(target)
          finders << BackupFolders::KnownLocations.new(target)
        end
      end
    end
  end
end
