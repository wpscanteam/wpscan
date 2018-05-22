# encoding: UTF-8

class WebSite
  module SecurityTxt

    # Gets the security.txt URL
    # @return [ String ]
    def security_url
      @uri.clone.merge('.well-known/security.txt').to_s
    end

  end
end
