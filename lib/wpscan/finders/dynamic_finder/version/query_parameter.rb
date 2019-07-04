# frozen_string_literal: true

module WPScan
  module Finders
    module DynamicFinder
      module Version
        # Version finder using QueryParameter method
        class QueryParameter < Finders::DynamicFinder::Version::Finder
          # @return [ Hash ]
          def self.child_class_constants
            @child_class_constants ||= super().merge(
              XPATH: nil, FILES: nil, PATTERN: /(?:v|ver|version)\=(?<v>\d+\.[\.\d]+)/i, CONFIDENCE_PER_OCCURENCE: 10
            )
          end

          # @param [ Typhoeus::Response ] response
          # @param [ Hash ] opts
          # @return [ Array<Version>, nil ]
          def find(response, _opts = {})
            found = []

            scan_response(response).each do |version_number, occurences|
              found << create_version(
                version_number,
                confidence: self.class::CONFIDENCE_PER_OCCURENCE * occurences.size,
                interesting_entries: occurences
              )
            end

            found.compact
          end

          # @param [ Typhoeus::Response ] response
          # @return [ Hash ]
          def scan_response(response)
            found = {}

            target.in_scope_uris(response, xpath) do |uri|
              next unless uri.path =~ path_pattern && uri.query&.match(self.class::PATTERN)

              version = Regexp.last_match[:v].to_s

              found[version] ||= []
              found[version] << uri.to_s
            end

            found
          end

          # @return [ String ]
          def xpath
            @xpath ||= self.class::XPATH || '//link[@href]/@href|//script[@src]/@src'
          end

          # @return [ Regexp ]
          def path_pattern
            @path_pattern ||= %r{/(?:#{self.class::FILES.join('|')})\z}i
          end
        end
      end
    end
  end
end
