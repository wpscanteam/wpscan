# frozen_string_literal: true

module WPScan
  module Finders
    module Plugins
      # Plugins finder from the Dynamic Finder 'JavascriptVar'
      class JavascriptVar < Finders::DynamicFinder::WpItems::Finder
        DEFAULT_CONFIDENCE = 60

        # @param [ Hash ] opts The options from the #passive, #aggressive methods
        # @param [ Typhoeus::Response ] response
        # @param [ String ] slug
        # @param [ String ] klass
        # @param [ Hash ] config The related dynamic finder config hash
        #
        # @return [ Plugin ] The detected plugin in the response, related to the config
        def process_response(opts, response, slug, klass, config)
          response.html.xpath(config['xpath'] || '//script[not(@src)]').each do |node|
            next if config['pattern'] && !node.text.match(config['pattern'])

            return Model::Plugin.new(
              slug,
              target,
              opts.merge(found_by: found_by(klass), confidence: config['confidence'] || DEFAULT_CONFIDENCE)
            )
          end
        end
      end
    end
  end
end
