# encoding: UTF-8

class WebSite
  module HumansTxt

    # Gets the humans.txt URL
    # @return [ String ]
    def humans_url
      @uri.clone.merge('humans.txt').to_s
    end

  end
end
