# frozen_string_literal: true

require_relative 'timthumb_version/bad_request'

module WPScan
  module Finders
    module TimthumbVersion
      # Timthumb Version Finder
      class Base
        include CMSScanner::Finders::UniqueFinder

        # @param [ Model::Timthumb ] target
        def initialize(target)
          finders << TimthumbVersion::BadRequest.new(target)
        end
      end
    end
  end
end
