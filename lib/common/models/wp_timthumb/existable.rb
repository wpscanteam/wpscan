# encoding: UTF-8

class WpTimthumb < WpItem
  module Existable

    # @param [ Typhoeus::Response ] response
    # @param [ Hash ] options
    #
    # @return [ Boolean ]
    def exists_from_response?(response, options = {})
      response.code == 400 && response.body =~ /no image specified/i ? true : false
    end

  end
end
