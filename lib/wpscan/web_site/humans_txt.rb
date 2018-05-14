# encoding: UTF-8

class WebSite
  module HumansTxt

    # Gets a humans.txt URL
    # @return [ String ]
    def humans_url
      @uri.clone.merge('humans.txt').to_s
    end

    # Parse humans.txt
    # @return [ Array ] URLs generated from humans.txt
    def parse_humans_txt
      return_object = []
      response = Browser.get(humans_url.to_s)
      body = response.body

      # Get all non-comments
      entries = body.split(/\n/)

      # Did we get something?
      if entries
        # Remove any rubbish
        entries = clean_uri(entries)
      end
      return return_object
    end

  end
end
