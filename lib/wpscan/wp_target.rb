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

class WpTarget
  include WebSite
  include WpReadme
  include WpFullPathDisclosure
  include WpConfigBackup
  include WpLoginProtection
  include Malwares
  include WpUsernames
  include WpTimthumbs
  include WpPlugins
  include WpThemes
  include BruteForce

  @error_404_hash = nil

  attr_reader :uri, :verbose

  def initialize(target_url, options = {})
    @uri            = URI.parse(add_trailing_slash(add_http_protocol(target_url)))
    @verbose        = options[:verbose]
    @wp_content_dir = options[:wp_content_dir]
    @wp_plugins_dir = options[:wp_plugins_dir]

    Browser.instance(options.merge(:max_threads => options[:threads]))
  end

  # Alias of @uri.to_s
  def url
    @uri.to_s
  end

  def login_url
    url = @uri.merge("wp-login.php").to_s

    # Let's check if the login url is redirected (to https url for example)
    redirection = redirection(url)
    if redirection
      url = redirection
    end

    url
  end

  # Return the MD5 hash of a 404 page
  def error_404_hash
    unless @error_404_hash
      non_existant_page = Digest::MD5.hexdigest(rand(9999999999).to_s) + ".html"

      response = Browser.instance.get(@uri.merge(non_existant_page).to_s)

      @error_404_hash = Digest::MD5.hexdigest(response.body)
    end

    @error_404_hash
  end

  # Valid HTTP return codes
  def self.valid_response_codes
    [200, 403, 301, 302, 500]
  end

  # return WpTheme
  def theme
    WpTheme.find(@uri)
  end

  # return WpVersion
  def version
    WpVersion.find(@uri, wp_content_dir)
  end

  def wp_content_dir
    unless @wp_content_dir
      index_body = Browser.instance.get(@uri.to_s).body
      # Only use the path because domain can be text or an ip
      uri_path = @uri.path

      if index_body[/#{Regexp.escape(uri_path)}\/wp-content\/(?:themes|plugins)\//i]
        @wp_content_dir = "wp-content"
      else
        @wp_content_dir = index_body[/(?:href|src)\s*=\s*(?:"|').+#{Regexp.escape(uri_path)}([^"']+)\/(?:themes|plugins)\/.*(?:"|')/i, 1]
      end
    end
    @wp_content_dir
  end

  def wp_plugins_dir
    unless @wp_plugins_dir
      @wp_plugins_dir = "#{wp_content_dir}/plugins"
    end
    @wp_plugins_dir
  end

  def wp_plugins_dir_exists?
    Browser.instance.get(@uri.merge(wp_plugins_dir)).code != 404
  end

  def has_debug_log?
    # We only get the first 700 bytes of the file to avoid loading huge file (like 2Go)
    response_body = Browser.instance.get(debug_log_url(), :headers => {"range" => "bytes=0-700"}).body
    response_body[%r{\[[^\]]+\] PHP (?:Warning|Error|Notice):}] ? true : false
  end

  def debug_log_url
    @uri.merge("#{wp_content_dir()}/debug.log").to_s
  end

  # Script for replacing strings in wordpress databases
  # reveals databse credentials after hitting submit
  # http://interconnectit.com/124/search-and-replace-for-wordpress-databases/
  def search_replace_db_2_url
    @uri.merge("searchreplacedb2.php").to_s
  end

  def search_replace_db_2_exists?
    resp = Browser.instance.get(search_replace_db_2_url)
    resp.code == 200 && resp.body[%r{by interconnect}i]
  end

  # Should check wp-login.php if registration is enabled or not
  def registration_enabled?
    resp = Browser.instance.get(registration_url)
    # redirect only on non multi sites
    if resp.code == 302 and resp.headers_hash["location"] =~ /wp-login\.php\?registration=disabled/i
      enabled = false
    # multi site registration form
    elsif resp.code == 200 and resp.body =~ /<form id="setupform" method="post" action="[^"]*wp-signup\.php[^"]*">/i
      enabled = true
    # normal registration form
    elsif resp.code == 200 and resp.body =~ /<form name="registerform" id="registerform" action="[^"]*wp-login\.php[^"]*"/i
      enabled = true
    # registration disabled
    else
      enabled = false
    end
    enabled
  end

  def registration_url
    is_multisite? ? @uri.merge("wp-signup.php") : @uri.merge("wp-login.php?action=register")
  end

  def is_multisite?
    unless @multisite
      # when multi site, there is no redirection or a redirect to the site itself
      # otherwise redirect to wp-login.php
      url = @uri.merge("wp-signup.php")
      resp = Browser.instance.get(url)
      if resp.code == 302 and resp.headers_hash["location"] =~ /wp-login\.php\?action=register/
        @multisite = false
      elsif resp.code == 302 and resp.headers_hash["location"] =~ /wp-signup\.php/
        @multisite = true
      elsif resp.code == 200
        @multisite = true
      else
        @multisite = false
      end
    end
    @multisite
  end
end
