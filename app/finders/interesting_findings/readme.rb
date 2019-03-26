# frozen_string_literal: true

module WPScan
  module Finders
    module InterestingFindings
      # Readme.html finder
      class Readme < CMSScanner::Finders::Finder
        # @return [ InterestingFinding ]
        def aggressive(_opts = {})
          potential_files.each do |path|
            res = target.head_and_get(path)

            next unless res.code == 200 && res.body =~ /wordpress/i

            return Model::Readme.new(target.url(path), confidence: 100, found_by: DIRECT_ACCESS)
          end

          nil
        end

        # @retun [ Array<String> ] The list of potential readme files
        def potential_files
          %w[readme.html olvasdel.html lisenssi.html liesmich.html]
        end
      end
    end
  end
end
