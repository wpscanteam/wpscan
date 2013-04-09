# encoding: UTF-8

class Browser
  module Actions

    # @param [ String ] url
    # @param [ Hash ] params
    #
    # @return [ Typhoeus::Response ]
    def get(url, params = {})
      #Typhoeus.get(url, Browser.instance.merge_request_params(params))
      process(url, params.merge(method: :get))
    end

    # @param [ String ] url
    # @param [ Hash ] params
    #
    # @return [ Typhoeus::Response ]
    def post(url, params = {})
      #Typhoeus.post(url, Browser.instance.merge_request_params(params))
      process(url, params.merge(method: :post))
    end

    # @param [ String ] url
    # @param [ Hash ] params
    #
    # @return [ Typhoeus::Response ]
    def get_and_follow_location(url, params = {})
      params[:maxredirs] ||= 2

      get(url, params.merge(followlocation: true))
    end

    protected

    # @param [ String ] url
    # @param [ Hash ] params
    #
    # @return [ Typhoeus::Response ]
    def process(url, params)
      browser = Browser.instance

      browser.run_request(
        browser.forge_request(url, params)
      )
    end

  end
end
