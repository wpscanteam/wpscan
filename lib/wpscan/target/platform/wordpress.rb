# frozen_string_literal: true

%w[custom_directories].each do |required|
  require "wpscan/target/platform/wordpress/#{required}"
end

module WPScan
  class Target < CMSScanner::Target
    module Platform
      # Some WordPress specific implementation
      module WordPress
        include CMSScanner::Target::Platform::PHP

        WORDPRESS_PATTERN      = %r{/(?:(?:wp-content/(?:themes|(?:mu\-)?plugins|uploads))|wp-includes)/}i.freeze
        WP_JSON_OEMBED_PATTERN = %r{/wp\-json/oembed/}i.freeze
        WP_ADMIN_AJAX_PATTERN  = %r{\\?/wp\-admin\\?/admin\-ajax\.php}i.freeze

        # These methods are used in the associated interesting_findings finders
        # to keep the boolean state of the finding rather than re-check the whole thing again
        attr_accessor :multisite, :registration_enabled, :mu_plugins
        alias multisite? multisite
        alias registration_enabled? registration_enabled
        alias mu_plugins? mu_plugins

        # @param [ Symbol ] detection_mode
        #
        # @return [ Boolean ] Whether or not the target is running WordPress
        def wordpress?(detection_mode)
          [homepage_res, error_404_res].each do |page_res|
            return true if wordpress_from_meta_comments_or_scripts?(page_res)
          end

          if %i[mixed aggressive].include?(detection_mode)
            %w[wp-admin/install.php wp-login.php].each do |path|
              res = Browser.get_and_follow_location(url(path))

              next unless res.code == 200

              in_scope_uris(res, '//link/@href|//script/@src') do |uri|
                return true if WORDPRESS_PATTERN.match?(uri.path)
              end
            end
          end

          false
        end

        # @param [ Typhoeus::Response ] response
        # @return [ Boolean ]
        def wordpress_from_meta_comments_or_scripts?(response)
          in_scope_uris(response, '//link/@href|//script/@src') do |uri|
            return true if WORDPRESS_PATTERN.match?(uri.path) || WP_JSON_OEMBED_PATTERN.match?(uri.path)
          end

          return true if response.html.css('meta[name="generator"]').any? do |node|
            /wordpress/i.match?(node['content'])
          end

          return true unless comments_from_page(/wordpress/i, response).empty?

          return true if response.html.xpath('//script[not(@src)]').any? do |node|
            WP_ADMIN_AJAX_PATTERN.match?(node.text)
          end

          false
        end

        COOKIE_PATTERNS = {
          'vjs' => /createCookie\('vjs','(?<c_value>\d+)',\d+\);/i
        }.freeze

        # Sometimes there is a mechanism in place on the blog, which requires a specific
        # cookie and value to be added to requests. Lets try to detect and add them
        def maybe_add_cookies
          COOKIE_PATTERNS.each do |cookie_key, pattern|
            next unless homepage_res.body =~ pattern

            browser = Browser.instance

            cookie_string = "#{cookie_key}=#{Regexp.last_match[:c_value]}"

            cookie_string += "; #{browser.cookie_string}" if browser.cookie_string

            browser.cookie_string = cookie_string

            # Force recheck of the homepage when retying wordpress?
            # No need to clear the cache, as the request (which will contain the cookies)
            # will be different
            @homepage_res = nil
            @homepage_url = nil

            break
          end
        end

        # @return [ String ]
        def registration_url
          multisite? ? url('wp-signup.php') : url('wp-login.php?action=register')
        end

        # @return [ Boolean ] Whether or not the target is hosted on wordpress.com
        def wordpress_hosted?
          return true if /\.wordpress\.com$/i.match?(uri.host)

          unless content_dir
            pattern = %r{https?://s\d\.wp\.com#{WORDPRESS_PATTERN}}i.freeze
            xpath   = '(//@href|//@src)[contains(., "wp.com")]'

            uris_from_page(homepage_res, xpath) do |uri|
              return true if uri.to_s.match?(pattern)
            end
          end

          false
        end

        # @param [ String ] username
        # @param [ String ] password
        #
        # @return [ Typhoeus::Response ]
        def do_login(username, password)
          login_request(username, password).run
        end

        # @param [ String ] username
        # @param [ String ] password
        #
        # @return [ Typhoeus::Request ]
        def login_request(username, password)
          Browser.instance.forge_request(
            login_url,
            method: :post,
            cache_ttl: 0,
            body: { log: username, pwd: password }
          )
        end

        # The login page is checked for a potential redirection (from http to https)
        # the first time the method is called, and the effective_url is then used
        # if suitable, otherwise the default wp-login will be.
        #
        # @return [ String ] The URL to the login page
        def login_url
          return @login_url if @login_url

          @login_url = url('wp-login.php')

          res = Browser.get_and_follow_location(@login_url)

          @login_url = res.effective_url if res.effective_url =~ /wp\-login\.php\z/i && in_scope?(res.effective_url)

          @login_url
        end
      end
    end
  end
end
