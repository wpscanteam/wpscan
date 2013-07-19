# encoding: UTF-8

class Browser
  module Actions

    # @param [ String ] url
    # @param [ Hash ] params
    #
    # @return [ Typhoeus::Response ]
    def get(url, params = {})
      process(url, params.merge(method: :get))
    end

    # @param [ String ] url
    # @param [ Hash ] params
    #
    # @return [ Typhoeus::Response ]
    def post(url, params = {})
      process(url, params.merge(method: :post))
    end

    # @param [ String ] url
    # @param [ Hash ] params
    #
    # @return [ Typhoeus::Response ]
    def head(url, params = {})
      process(url, params.merge(method: :head))
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
      Typhoeus::Request.new(url, Browser.instance.merge_request_params(params)).run
    end

  end
end
