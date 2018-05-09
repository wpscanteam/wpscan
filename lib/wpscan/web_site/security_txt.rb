# encoding: UTF-8

class WebSite
  module SecurityTxt

    # Checks if a security.txt file exists
    # @return [ Boolean ]
    def has_security?
      Browser.get(security_url).code == 200
    end

    # Gets a security.txt URL
    # @return [ String ]
    def security_url
      @uri.clone.merge('.well-known/security.txt').to_s
    end

    # Parse security.txt
    # @return [ Array ] URLs generated from security.txt
    def parse_security_txt
      return unless has_security?

      return_object = []
      response = Browser.get(security_url.to_s)
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
