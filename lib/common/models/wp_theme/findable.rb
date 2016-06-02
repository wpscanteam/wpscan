# encoding: UTF-8

class WpTheme < WpItem
  module Findable

    # Find the main theme of the blog
    #
    # @param [ URI ] target_uri
    #
    # @return [ WpTheme ]
    def find(target_uri)
      methods.grep(/^find_from_/).each do |method|
        if wp_theme = self.send(method, target_uri)
          wp_theme.found_from = method.to_s

          return wp_theme
        end
      end
      nil
    end

    protected

    # Discover the wordpress theme by parsing the css link rel
    #
    # @param [ URI ] target_uri
    #
    # @return [ WpTheme ]
    def find_from_css_link(target_uri)
      response = Browser.get_and_follow_location(target_uri.to_s)

      # https + domain is optional because of relative links
      return unless response.body =~ %r{(?:https?://[^"']+/)?([^/\s]+)/themes/([^"'/]+)[^"']*/style.css}i

      new(
        target_uri,
        name:           Regexp.last_match[2],
        referenced_url: Regexp.last_match[0],
        wp_content_dir: Regexp.last_match[1]
      )
    end

    # @param [ URI ] target_uri
    #
    # @return [ WpTheme ]
    def find_from_wooframework(target_uri)
      body = Browser.get(target_uri.to_s).body
      regexp = %r{<meta name="generator" content="([^\s"]+)\s?([^"]+)?" />\s+<meta name="generator" content="WooFramework\s?([^"]+)?" />}

      if matches = regexp.match(body)
        woo_theme_name = matches[1]
        woo_theme_version = matches[2]
        #woo_framework_version = matches[3] # Not used at this time

        return new(
          target_uri,
          name:    woo_theme_name,
          version: woo_theme_version
        )
      end
    end

  end
end
