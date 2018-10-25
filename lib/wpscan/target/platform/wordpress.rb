%w[custom_directories].each do |required|
  require "wpscan/target/platform/wordpress/#{required}"
end

module WPScan
  class Target < CMSScanner::Target
    module Platform
      # Some WordPress specific implementation
      module WordPress
        include CMSScanner::Target::Platform::PHP

        WORDPRESS_PATTERN = %r{/(?:(?:wp-content/(?:themes|(?:mu\-)?plugins|uploads))|wp-includes)/}i

        # These methods are used in the associated interesting_findings finders
        # to keep the boolean state of the finding rather than re-check the whole thing again
        attr_accessor :multisite, :registration_enabled, :mu_plugins
        alias multisite? multisite
        alias registration_enabled? registration_enabled
        alias mu_plugins? mu_plugins

        # @return [ Boolean ]
        def wordpress?
          # res = Browser.get(url)

          in_scope_urls(homepage_res) do |url|
            return true if Addressable::URI.parse(url).path.match(WORDPRESS_PATTERN)
          end

          homepage_res.html.css('meta[name="generator"]').each do |node|
            return true if node['content'] =~ /wordpress/i
          end

          return true unless comments_from_page(/wordpress/i, homepage_res).empty?

          false
        end

        # @return [ String ]
        def registration_url
          multisite? ? url('wp-signup.php') : url('wp-login.php?action=register')
        end

        def wordpress_hosted?
          uri.host =~ /\.wordpress\.com$/i ? true : false
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
            body: { log: username, pwd: password }
          )
        end

        # @return [ String ] The URL to the login page
        def login_url
          url('wp-login.php')
        end
      end
    end
  end
end
