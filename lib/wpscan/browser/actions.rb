# frozen_string_literal: true

module CMSScanner
  class Browser
    # Browser Actions (get, post etc)
    module Actions
      # @param [ String ] url
      # @param [ Hash ] params
      #
      # @return [ Typhoeus::Request ]
      def forge_request(url, params = {})
        NS::Browser.instance.forge_request(url, params)
      end

      # @param [ String ] url
      # @param [ Hash ] params
      #
      # @return [ Typhoeus::Response ]
      def get(url, params = {})
        forge_request(url, params.merge(method: :get)).run
      end

      # @param [ String ] url
      # @param [ Hash ] params
      #
      # @return [ Typhoeus::Response ]
      def post(url, params = {})
        forge_request(url, params.merge(method: :post)).run
      end

      # @param [ String ] url
      # @param [ Hash ] params
      #
      # @return [ Typhoeus::Response ]
      def head(url, params = {})
        forge_request(url, params.merge(method: :head)).run
      end

      # @param [ String ] url
      # @param [ Hash ] params
      #
      # @return [ Typhoeus::Response ]
      def get_and_follow_location(url, params = {})
        get(url, { followlocation: true, maxredirs: 3 }.merge(params))
      end
    end
  end
end
