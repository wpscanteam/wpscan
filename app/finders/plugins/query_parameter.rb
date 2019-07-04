# frozen_string_literal: true

module WPScan
  module Finders
    module Plugins
      # Plugins finder from Dynamic Finder 'QueryParameter'
      class QueryParameter < Finders::DynamicFinder::WpItems::Finder
        DEFAULT_CONFIDENCE = 10

        def passive(_opts = {})
          # Handled by UrlsInHomePage, so no need to check this twice
        end

        # @param [ Hash ] opts The options from the #passive, #aggressive methods
        # @param [ Typhoeus::Response ] response
        # @param [ String ] slug
        # @param [ String ] klass
        # @param [ Hash ] config The related dynamic finder config hash
        #
        # @return [ Plugin ] The detected plugin in the response, related to the config
        def process_response(opts, response, slug, klass, config)
          # TODO: when a real case will be found
        end
      end
    end
  end
end
