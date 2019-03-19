module WPScan
  module Finders
    module InterestingFindings
      # Readme.html finder
      class Readme < CMSScanner::Finders::Finder
        # @return [ InterestingFinding ]
        def aggressive(_opts = {})
          potential_files.each do |file|
            url = target.url(file)
            res = Browser.get(url)

            if res.code == 200 && res.body =~ /wordpress/i
              return Model::Readme.new(url, confidence: 100, found_by: DIRECT_ACCESS)
            end
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
