# frozen_string_literal: true

module WPScan
  module Finders
    module DynamicFinder
      module Version
        # Version finder using JavaScript Variable method
        class JavascriptVar < Finders::DynamicFinder::Version::Finder
          # @return [ Hash ]
          def self.child_class_constants
            @child_class_constants ||= super().merge(
              XPATH: '//script[not(@src)]', VERSION_KEY: nil,
              PATTERN: nil, CONFIDENCE: 60
            )
          end

          # @param [ Typhoeus::Response ] response
          # @param [ Hash ] opts
          # @return [ Version ]
          def find(response, _opts = {})
            target.xpath_pattern_from_page(
              self.class::XPATH, self.class::PATTERN, response
            ) do |match_data, _node|
              next unless (version_number = version_number_from_match_data(match_data))

              # If the text to be output in the interesting_entries is > 50 chars,
              # get 20 chars before and after (when possible) the detected version instead
              match = match_data.to_s
              match = match[/.*?(.{,20}#{Regexp.escape(version_number)}.{,20}).*/, 1] if match.size > 50

              return create_version(
                version_number,
                interesting_entries: ["#{response.effective_url}, Match: '#{match.strip}'"]
              )
            end
            nil
          end

          # @param [ MatchData ] match_data
          # @return [ String ]
          def version_number_from_match_data(match_data)
            if self.class::VERSION_KEY
              begin
                json = JSON.parse("{#{match_data[:json].strip.chomp(',').tr("'", '"')}}")
              rescue JSON::ParserError
                return
              end

              json.dig(*self.class::VERSION_KEY.split(':'))
            else
              match_data[:v]
            end
          end
        end
      end
    end
  end
end
