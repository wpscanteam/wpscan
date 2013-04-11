# encoding: UTF-8

class WpTarget < WebSite
  module WpRegistrable

    # Should check wp-login.php if registration is enabled or not
    #
    # @return [ Boolean ]
    def registration_enabled?
      resp = Browser.get(registration_url)
      # redirect only on non multi sites
      if resp.code == 302 and resp.headers_hash['location'] =~ /wp-login\.php\?registration=disabled/i
        enabled = false
      # multi site registration form
      elsif resp.code == 200 and resp.body =~ /<form id="setupform" method="post" action="[^"]*wp-signup\.php[^"]*">/i
        enabled = true
      # normal registration form
      elsif resp.code == 200 and resp.body =~ /<form name="registerform" id="registerform" action="[^"]*wp-login\.php[^"]*"/i
        enabled = true
      # registration disabled
      else
        enabled = false
      end
      enabled
    end

    # @return [ String ] The registration URL
    def registration_url
      multisite? ? @uri.merge('wp-signup.php').to_s : @uri.merge('wp-login.php?action=register').to_s
    end

    # @return [ Boolean ]
    def multisite?
      unless @multisite
        # when multi site, there is no redirection or a redirect to the site itself
        # otherwise redirect to wp-login.php
        resp = Browser.get(@uri.merge('wp-signup.php').to_s)

        if resp.code == 302 and resp.headers_hash['location'] =~ /wp-login\.php\?action=register/
          @multisite = false
        elsif resp.code == 302 and resp.headers_hash['location'] =~ /wp-signup\.php/
          @multisite = true
        elsif resp.code == 200
          @multisite = true
        else
          @multisite = false
        end
      end
      @multisite
    end

  end
end
