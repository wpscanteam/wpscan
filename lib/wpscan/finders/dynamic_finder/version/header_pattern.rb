# frozen_string_literal: true

module WPScan
  module Finders
    module DynamicFinder
      module Version
        # Version finder using Header Pattern method
        class HeaderPattern < Finders::DynamicFinder::Version::Finder
          # @return [ Hash ]
          def self.child_class_constants
            @child_class_constants ||= super().merge(HEADER: nil, PATTERN: nil, CONFIDENCE: 60)
          end

          # @param [ Typhoeus::Response ] response
          # @param [ Hash ] opts
          # @return [ Version ]
          def find(response, _opts = {})
            return unless response.headers && response.headers[self.class::HEADER]
            return unless response.headers[self.class::HEADER].to_s =~ self.class::PATTERN

            create_version(
              Regexp.last_match[:v],
              interesting_entries: ["#{response.effective_url}, Match: '#{Regexp.last_match}'"]
            )
          end
        end
      end
    end
  end
end
