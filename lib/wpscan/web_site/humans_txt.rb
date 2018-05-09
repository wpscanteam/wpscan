# encoding: UTF-8

class WebSite
  module HumansTxt

    # Checks if a humans.txt file exists
    # @return [ Boolean ]
    def has_humans?
      Browser.get(humans_url).code == 200
    end

    # Gets a humans.txt URL
    # @return [ String ]
    def humans_url
      @uri.clone.merge('humans.txt').to_s
    end

    # Parse humans.txt
    # @return [ Array ] URLs generated from humans.txt
    def parse_humans_txt
      return unless has_humans?

      return_object = []
      response = Browser.get(humans_url.to_s)
      entries = response.body.split(/\n/)
      if entries
        entries.flatten!
        entries.uniq!

        entries.each do |d|
          temp = d.strip
          return_object << temp.to_s
        end
      end
      return_object
    end

  end
end
