# frozen_string_literal: true

module WPScan
  class Target < CMSScanner::Target
    module Platform
      # wp-content & plugins directory implementation
      module WordPress
        def content_dir=(dir)
          @content_dir = dir.chomp('/')
        end

        def plugins_dir=(dir)
          @plugins_dir = dir.chomp('/')
        end

        # @return [ String ] The wp-content directory
        def content_dir
          unless @content_dir
            # scope_url_pattern is from CMSScanner::Target
            pattern = %r{#{scope_url_pattern}([\w\s\-/]+?)\\?/(?:themes|plugins|uploads|cache)\\?/}i

            [homepage_res, error_404_res].each do |page_res|
              in_scope_uris(page_res, '//link/@href|//script/@src|//img/@src') do |uri|
                return @content_dir = Regexp.last_match[1] if uri.to_s.match(pattern)
              end

              # Checks for the pattern in raw JS code, as well as @content attributes of meta tags
              xpath_pattern_from_page('//script[not(@src)]|//meta/@content', pattern, page_res) do |match|
                return @content_dir = match[1]
              end
            end

            return @content_dir = 'wp-content' if default_content_dir_exists?
          end

          @content_dir
        end

        def default_content_dir_exists?
          # url('wp-content') can't be used here as the folder has not yet been identified
          # and the method would try to replace it by nil which would raise an error
          [200, 401, 403].include?(Browser.forge_request(uri.join('wp-content/').to_s, head_or_get_params).run.code)
        end

        # @return [ Addressable::URI ]
        def content_uri
          uri.join("#{content_dir}/")
        end

        # @return [ String ]
        def content_url
          content_uri.to_s
        end

        # @return [ String ]
        def plugins_dir
          @plugins_dir ||= "#{content_dir}/plugins"
        end

        # @return [ Addressable::URI ]
        def plugins_uri
          uri.join("#{plugins_dir}/")
        end

        # @return [ String ]
        def plugins_url
          plugins_uri.to_s
        end

        # @param [ String ] slug
        #
        # @return [ String ]
        def plugin_url(slug)
          plugins_uri.join("#{Addressable::URI.encode(slug)}/").to_s
        end

        # @return [ String ]
        def themes_dir
          @themes_dir ||= "#{content_dir}/themes"
        end

        # @return [ Addressable::URI ]
        def themes_uri
          uri.join("#{themes_dir}/")
        end

        # @return [ String ]
        def themes_url
          themes_uri.to_s
        end

        # @param [ String ] slug
        #
        # @return [ String ]
        def theme_url(slug)
          themes_uri.join("#{Addressable::URI.encode(slug)}/").to_s
        end

        # @return [ String, False ] String of the sub_dir found, false otherwise
        # @note: nil can not be returned here, otherwise if there is no sub_dir
        #        the check would be done each time, which would make enumeration of
        #        long list of items very slow to generate
        def sub_dir
          return @sub_dir unless @sub_dir.nil?

          # url_pattern is from CMSScanner::Target
          pattern = %r{#{url_pattern}(.+?)/(?:xmlrpc\.php|wp-includes/)}i
          xpath = '(//@src|//@href|//@data-src)[contains(., "xmlrpc.php") or contains(., "wp-includes/")]'

          [homepage_res, error_404_res].each do |page_res|
            in_scope_uris(page_res, xpath) do |uri|
              return @sub_dir = Regexp.last_match[1] if uri.to_s.match(pattern)
            end
          end

          @sub_dir = false
        end

        # Override of the WebSite#url to consider the custom WP directories
        #
        # @param [ String ] path Optional path to merge with the uri
        #
        # @return [ String ]
        def url(path = nil)
          return @uri.to_s unless path

          if %r{wp-content/plugins}i.match?(path)
            new_path = path.gsub('wp-content/plugins', plugins_dir)
          elsif /wp-content/i.match?(path)
            new_path = path.gsub('wp-content', content_dir)
          elsif path[0] != '/' && sub_dir
            new_path = "#{sub_dir}/#{path}"
          end

          super(new_path || path)
        end
      end
    end
  end
end
