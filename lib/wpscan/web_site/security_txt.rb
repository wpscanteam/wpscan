# encoding: UTF-8

class WebSite
  module SecurityTxt

    # Gets a security.txt URL
    # @return [ String ]
    def security_url
      @uri.clone.merge('.well-known/security.txt').to_s
    end

    # Parse security.txt
    # @return [ Array ] URLs generated from security.txt
    def parse_security_txt
      return_object = []
      response = Browser.get(security_url.to_s)
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
