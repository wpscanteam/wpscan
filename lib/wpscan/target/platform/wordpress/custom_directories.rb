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
            escaped_url = Regexp.escape(url).gsub(/https?/i, 'https?')
            pattern     = %r{#{escaped_url}([^\/]+)\/(?:themes|plugins|uploads|cache)\/}i

            in_scope_urls(homepage_res) do |url|
              return @content_dir = Regexp.last_match[1] if url.match(pattern)
            end

            xpath_pattern_from_page('//script[not(@src)]', pattern, homepage_res) do |match|
              return @content_dir = match[1]
            end
          end

          @content_dir
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
          plugins_uri.join("#{URI.encode(slug)}/").to_s
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
          themes_uri.join("#{URI.encode(slug)}/").to_s
        end

        # TODO: Factorise the code and the content_dir one ?
        # @return [ String, False ] String of the sub_dir found, false otherwise
        # @note: nil can not be returned here, otherwise if there is no sub_dir
        #        the check would be done each time
        def sub_dir
          unless @sub_dir
            escaped_url = Regexp.escape(url).gsub(/https?/i, 'https?')
            pattern     = %r{#{escaped_url}(.+?)\/(?:xmlrpc\.php|wp\-includes\/)}i

            in_scope_urls(homepage_res) do |url|
              return @sub_dir = Regexp.last_match[1] if url.match(pattern)
            end

            @sub_dir = false
          end

          @sub_dir
        end

        # Override of the WebSite#url to consider the custom WP directories
        #
        # @param [ String ] path Optional path to merge with the uri
        #
        # @return [ String ]
        def url(path = nil)
          return @uri.to_s unless path

          if path =~ %r{wp\-content/plugins}i
            path.gsub!('wp-content/plugins', plugins_dir)
          elsif path =~ /wp\-content/i
            path.gsub!('wp-content', content_dir)
          elsif path[0] != '/' && sub_dir
            path = "#{sub_dir}/#{path}"
          end

          super(path)
        end
      end
    end
  end
end
