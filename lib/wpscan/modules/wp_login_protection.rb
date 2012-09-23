#--
# WPScan - WordPress Security Scanner
# Copyright (C) 2012
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#++

module WpLoginProtection

  LOGIN_PROTECTION_METHOD_PATTERN = /^has_(.*)_protection\?/i
  # Used as cache
  @login_protection_plugin = nil

  def has_login_protection?
    !login_protection_plugin().nil?
  end

  # Checks if a login protection plugin is enabled
  # http://code.google.com/p/wpscan/issues/detail?id=111
  # return a WpPlugin object or nil if no one is found
  def login_protection_plugin
    unless @login_protection_plugin
      protected_methods.grep(LOGIN_PROTECTION_METHOD_PATTERN).each do |symbol_to_call|

        if send(symbol_to_call)
          plugin_name = symbol_to_call[LOGIN_PROTECTION_METHOD_PATTERN, 1].gsub('_', '-')

          return @login_protection_plugin = WpPlugin.new(
              :name           => plugin_name,
              :base_url       => @uri,
              :path           => "/plugins/#{plugin_name}/",
              :wp_content_dir => @wp_content_dir
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
    Browser.instance.get(login_url()).body =~ %r{Login LockDown}i ? true : false
  end

  # http://wordpress.org/extend/plugins/login-lock/
  def has_login_lock_protection?
    Browser.instance.get(login_url()).body =~ %r{LOGIN LOCK} ? true : false
  end

  # http://wordpress.org/extend/plugins/better-wp-security/
  def has_better_wp_security_protection?
    Browser.instance.get(better_wp_security_url()).code != 404
  end

  def better_wp_security_url
    WpPlugin.new(:wp_content_dir  => @wp_content_dir,
                 :base_url        => @uri,
                 :path            => "/plugins/better-wp-security/",
                 :name            => "better-wp-security"
    ).get_url_without_filename
  end

  # http://wordpress.org/extend/plugins/simple-login-lockdown/
  def has_simple_login_lockdown_protection?
    Browser.instance.get(simple_login_lockdown_url()).code != 404
  end

  def simple_login_lockdown_url
    WpPlugin.new(:wp_content_dir  => @wp_content_dir,
                 :base_url        => @uri,
                 :path            => "/plugins/simple-login-lockdown/",
                 :name            => "simple-login-lockdown"
    ).get_url_without_filename
  end

  # http://wordpress.org/extend/plugins/login-security-solution/
  def has_login_security_solution_protection?
    Browser.instance.get(login_security_solution_url()).code != 404
  end

  def login_security_solution_url
    WpPlugin.new(:wp_content_dir  => @wp_content_dir,
                 :base_url        => @uri,
                 :path            => "/plugins/login-security-solution/",
                 :name            => "login-security-solution"
    ).get_url_without_filename
  end

  # http://wordpress.org/extend/plugins/limit-login-attempts/
  def has_limit_login_attempts_protection?
    Browser.instance.get(limit_login_attempts_url()).code != 404
  end

  def limit_login_attempts_url
    WpPlugin.new(:wp_content_dir  => @wp_content_dir,
                 :base_url        => @uri,
                 :path            => "/plugins/limit-login-attempts/",
                 :name            => "limit-login-attempts"
    ).get_url_without_filename
  end

  # http://wordpress.org/extend/plugins/bluetrait-event-viewer/
  def has_bluetrait_event_viewer_protection?
    Browser.instance.get(bluetrait_event_viewer_url()).code != 404
  end

  def bluetrait_event_viewer_url
    WpPlugin.new(:wp_content_dir  => @wp_content_dir,
                 :base_url        => @uri,
                 :path            => "/plugins/bluetrait-event-viewer/",
                 :name            => "bluetrait-event-viewer"
    ).get_url_without_filename
  end
end
