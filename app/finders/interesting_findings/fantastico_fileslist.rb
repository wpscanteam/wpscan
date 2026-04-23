# frozen_string_literal: true

module WPScan
  module Finders
    module InterestingFindings
      # FantasticoFileslist finder
      class FantasticoFileslist < Finder
        # @return [ InterestingFinding ]
        def aggressive(_opts = {})
          path = 'fantastico_fileslist.txt'
          res  = target.head_and_get(path)

          return if res.body.strip.empty?
          return unless res.headers && res.headers['Content-Type']&.start_with?('text/plain')

          WPScan::Model::FantasticoFileslist.new(target.url(path), confidence: 70, found_by: found_by)
        end
      end
    end
  end
end
