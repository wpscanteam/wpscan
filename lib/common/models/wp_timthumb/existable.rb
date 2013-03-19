# encoding: UTF-8

class WpTimthumb < WpItem
  module Existable

    def exists_from_response?(response, options = {})
      response.code == 400 && response.body =~ /no image specified/i ? true : false
    end

  end
end
