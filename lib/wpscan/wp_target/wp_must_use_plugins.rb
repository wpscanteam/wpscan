# encoding: UTF-8

class WpTarget < WebSite
  module WpMustUsePlugins
    # Checks to see if the must use plugin folder exists
    #
    # @return [ Boolean ]
    def has_must_use_plugins?
      response = Browser.get(must_use_url)

      if response && [200, 401, 403].include?(response.code)
        return true if response.has_valid_hash?(error_404_hash_set, homepage_hash)
      end

      false
    end

    # @return [ String ] The must use plugins directory URL
    def must_use_url
      @uri.merge("#{wp_content_dir}/mu-plugins/").to_s
    end
  end
end
