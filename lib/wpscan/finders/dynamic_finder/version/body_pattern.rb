# frozen_string_literal: true

module WPScan
  module Finders
    module DynamicFinder
      module Version
        # Version finder using Body Pattern method. Typically used when the response is not
        # an HTML doc and Xpath can't be used
        class BodyPattern < Finders::DynamicFinder::Version::Finder
          # @return [ Hash ]
          def self.child_class_constants
            @child_class_constants ||= super().merge(PATTERN: nil, CONFIDENCE: 60)
          end

          # @param [ Typhoeus::Response ] response
          # @param [ Hash ] opts
          # @return [ Version ]
          def find(response, _opts = {})
            return unless response.code != 404 && response.body =~ self.class::PATTERN

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
