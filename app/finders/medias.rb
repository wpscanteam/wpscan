# frozen_string_literal: true

require_relative 'medias/attachment_brute_forcing'

module WPScan
  module Finders
    module Medias
      # Medias Finder
      class Base
        include CMSScanner::Finders::SameTypeFinder

        # @param [ WPScan::Target ] target
        def initialize(target)
          finders << Medias::AttachmentBruteForcing.new(target)
        end
      end
    end
  end
end
