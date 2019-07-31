# frozen_string_literal: true

module WPScan
  module Finders
    module Plugins
      # Plugins finder from Dynamic Finder 'BodyPattern'
      class BodyPattern < Finders::DynamicFinder::WpItems::Finder
        DEFAULT_CONFIDENCE = 30

        # @param [ Hash ] opts The options from the #passive, #aggressive methods
        # @param [ Typhoeus::Response ] response
        # @param [ String ] slug
        # @param [ String ] klass
        # @param [ Hash ] config The related dynamic finder config hash
        #
        # @return [ Plugin ] The detected plugin in the response, related to the config
        def process_response(opts, response, slug, klass, config)
          return unless response.body&.match?(config['pattern'])

          Model::Plugin.new(
            slug,
            target,
            opts.merge(found_by: found_by(klass), confidence: config['confidence'] || DEFAULT_CONFIDENCE)
          )
        end
      end
    end
  end
end
