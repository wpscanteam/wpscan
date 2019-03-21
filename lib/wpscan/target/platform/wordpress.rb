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

        WORDPRESS_PATTERN = %r{/(?:(?:wp-content/(?:themes|(?:mu\-)?plugins|uploads))|wp-includes)/}i.freeze

        # These methods are used in the associated interesting_findings finders
        # to keep the boolean state of the finding rather than re-check the whole thing again
        attr_accessor :multisite, :registration_enabled, :mu_plugins
        alias multisite? multisite
        alias registration_enabled? registration_enabled
        alias mu_plugins? mu_plugins

        # @param [ Symbol ] detection_mode
        #
        # @return [ Boolean ]
        def wordpress?(detection_mode)
          in_scope_urls(homepage_res) do |url|
            return true if Addressable::URI.parse(url).path.match(WORDPRESS_PATTERN)
          end

          homepage_res.html.css('meta[name="generator"]').each do |node|
            return true if node['content'] =~ /wordpress/i
          end

          return true unless comments_from_page(/wordpress/i, homepage_res).empty?

          if %i[mixed aggressive].include?(detection_mode)
            %w[wp-admin/install.php wp-login.php].each do |path|
              in_scope_urls(Browser.get_and_follow_location(url(path))).each do |url|
                return true if Addressable::URI.parse(url).path.match(WORDPRESS_PATTERN)
              end
            end
          end

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
