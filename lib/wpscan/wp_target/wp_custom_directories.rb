# encoding: UTF-8

class WpTarget < WebSite
  module WpCustomDirectories

    # @return [ String ] The wp-content directory
    def wp_content_dir
      unless @wp_content_dir
        index_body = Browser.get(@uri.to_s).body
        uri_path = @uri.path # Only use the path because domain can be text or an IP

        if index_body[/\/wp-content\/(?:themes|plugins)\//i] || default_wp_content_dir_exists?
          @wp_content_dir = 'wp-content'
        else
          domains_excluded = '(?:www\.)?(facebook|twitter)\.com'
          @wp_content_dir  = index_body[/(?:href|src)\s*=\s*(?:"|').+#{Regexp.escape(uri_path)}((?!#{domains_excluded})[^"']+)\/(?:themes|plugins)\/.*(?:"|')/i, 1]
        end
      end

      @wp_content_dir
    end

    # @return [ Boolean ]
    def default_wp_content_dir_exists?
      response = Browser.get(@uri.merge('wp-content').to_s)

      if WpTarget.valid_response_codes.include?(response.code)
        hash = WebSite.page_hash(response)
        return true if hash != error_404_hash and hash != homepage_hash
      end

      false
    end

    # @return [ String ] The wp-plugins directory
    def wp_plugins_dir
      unless @wp_plugins_dir
        @wp_plugins_dir = "#{wp_content_dir}/plugins"
      end
      @wp_plugins_dir
    end

    # @return [ Boolean ]
    def wp_plugins_dir_exists?
      Browser.get(@uri.merge(wp_plugins_dir).to_s).code != 404
    end

  end
end
