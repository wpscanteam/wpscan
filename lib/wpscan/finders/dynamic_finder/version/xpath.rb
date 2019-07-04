# frozen_string_literal: true

module WPScan
  module Finders
    module DynamicFinder
      module Version
        # Version finder using Xpath method
        class Xpath < Finders::DynamicFinder::Version::Finder
          # @return [ Hash ]
          def self.child_class_constants
            @child_class_constants ||= super().merge(
              XPATH: nil, PATTERN: /\A(?<v>\d+\.[\.\d]+)/, CONFIDENCE: 60
            )
          end

          # @param [ Typhoeus::Response ] response
          # @param [ Hash ] opts
          # @return [ Version ]
          def find(response, _opts = {})
            target.xpath_pattern_from_page(
              self.class::XPATH, self.class::PATTERN, response
            ) do |match_data, _node|
              next unless match_data[:v]

              return create_version(
                match_data[:v],
                interesting_entries: ["#{response.effective_url}, Match: '#{match_data}'"]
              )
            end
            nil
          end
        end
      end
    end
  end
end
