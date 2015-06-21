# encoding: UTF-8

class WpTarget < WebSite
  module WpLoginProtection

    LOGIN_PROTECTION_METHOD_PATTERN = /^has_(.*)_protection\?/i
    # Used as cache
    @login_protection_plugin = nil

    def has_login_protection?
      !login_protection_plugin.nil?
    end

    # Checks if a login protection plugin is enabled
    # return a WpPlugin object or nil if no one is found
    def login_protection_plugin
      unless @login_protection_plugin
        protected_methods.grep(LOGIN_PROTECTION_METHOD_PATTERN).each do |symbol_to_call|

          if send(symbol_to_call)
            plugin_name = symbol_to_call[LOGIN_PROTECTION_METHOD_PATTERN, 1].gsub('_', '-')

            return @login_protection_plugin = WpPlugin.new(
              @uri,
              name:           plugin_name,
              wp_content_dir: wp_content_dir,
              wp_plugins_dir: wp_plugins_dir
            )
          end
        end
        @login_protection_plugin = nil
      end
      @login_protection_plugin
    end

    protected
    # Thanks to Alip Aswalid for providing this method.
    # http://wordpress.org/extend/plugins/login-lockdown/
    def has_login_lockdown_protection?
      Browser.get(login_url).body =~ %r{Login LockDown}i ? true : false
    end

    # http://wordpress.org/extend/plugins/login-lock/
    def has_login_lock_protection?
      Browser.get(login_url).body =~ %r{LOGIN LOCK} ? true : false
    end

    # http://wordpress.org/extend/plugins/better-wp-security/
    def has_better_wp_security_protection?
      Browser.get(better_wp_security_url).code != 404
    end

    def plugin_url(plugin_name)
      WpPlugin.new(
        @uri,
        name:           plugin_name,
        wp_content_dir: wp_content_dir,
        wp_plugins_dir: wp_plugins_dir
      ).url
    end

    def better_wp_security_url
      plugin_url('better-wp-security/')
    end

    # http://wordpress.org/extend/plugins/simple-login-lockdown/
    def has_simple_login_lockdown_protection?
      Browser.get(simple_login_lockdown_url).code != 404
    end

    def simple_login_lockdown_url
      plugin_url('simple-login-lockdown/')
    end

    # http://wordpress.org/extend/plugins/login-security-solution/
    def has_login_security_solution_protection?
      Browser.get(login_security_solution_url).code != 404
    end

    def login_security_solution_url
      plugin_url('login-security-solution')
    end

    # http://wordpress.org/extend/plugins/limit-login-attempts/
    def has_limit_login_attempts_protection?
      Browser.get(limit_login_attempts_url).code != 404
    end

    def limit_login_attempts_url
      plugin_url('limit-login-attempts')
    end

    # http://wordpress.org/extend/plugins/bluetrait-event-viewer/
    def has_bluetrait_event_viewer_protection?
      Browser.get(bluetrait_event_viewer_url).code != 404
    end

    def bluetrait_event_viewer_url
      plugin_url('bluetrait-event-viewer')
    end

    # https://wordpress.org/plugins/security-protection/
    def has_security_protection_protection?
      Nokogiri::HTML(Browser.get(login_url).body).css('script').each do |node|
        return true if node['src'] =~ /security-protection.js/i
      end
      false
    end
  end
end
