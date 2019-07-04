# frozen_string_literal: true

module WPScan
  module Finders
    module Plugins
      # Plugins finder from Dynamic Finder 'ConfigParser'
      class ConfigParser < Finders::DynamicFinder::WpItems::Finder
        DEFAULT_CONFIDENCE = 40

        # @param [ Hash ] opts The options from the #passive, #aggressive methods
        # @param [ Typhoeus::Response ] response
        # @param [ String ] slug
        # @param [ String ] klass
        # @param [ Hash ] config The related dynamic finder config hash
        #
        # @return [ Plugin ] The detected plugin in the response, related to the config
        def _process_response(_opts, _response, slug, klass, config)
          #
          # TODO. Currently not implemented, and not even loaded by the Finders, as this
          # finder only has an aggressive method, which has been disabled (globally)
          # when checking for plugins
          #

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
