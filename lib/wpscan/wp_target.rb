# encoding: UTF-8
#--
# WPScan - WordPress Security Scanner
# Copyright (C) 2012-2013
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

require 'web_site'
require 'modules/wp_readme'
require 'modules/wp_full_path_disclosure'
require 'modules/wp_config_backup'
require 'modules/wp_login_protection'
require 'modules/malwares'
require 'modules/brute_force'

class WpTarget < WebSite
  include WpReadme
  include WpFullPathDisclosure
  include WpConfigBackup
  include WpLoginProtection
  include Malwares
  include BruteForce

  attr_reader :verbose

  def initialize(target_url, options = {})
    super(target_url)

    @verbose        = options[:verbose]
    @wp_content_dir = options[:wp_content_dir]
    @wp_plugins_dir = options[:wp_plugins_dir]
    @multisite      = nil

    Browser.instance(options.merge(:max_threads => options[:threads]))
  end

  # check if the target website is
  # actually running wordpress.
  def wordpress?
    wordpress = false

    response = Browser.instance.get_and_follow_location(@uri.to_s)

    if response.body =~ /["'][^"']*\/wp-content\/[^"']*["']/i
      wordpress = true
    else
      response = Browser.instance.get_and_follow_location(xml_rpc_url)

      if response.body =~ %r{XML-RPC server accepts POST requests only}i
        wordpress = true
      else
        response = Browser.instance.get_and_follow_location(login_url)

        if response.code == 200 && response.body =~ %r{WordPress}i
          wordpress = true
        end
      end
    end

    wordpress
  end

  def login_url
    url = @uri.merge('wp-login.php').to_s

    # Let's check if the login url is redirected (to https url for example)
    redirection = redirection(url)
    if redirection
      url = redirection
    end

    url
  end

  # Valid HTTP return codes
  def self.valid_response_codes
    [200, 301, 302, 401, 403, 500, 400]
  end

  # return WpTheme
  def theme
    WpTheme.find(@uri)
  end

  # @param [ String ] versions_xml
  #
  # @return [ WpVersion ]
  def version(versions_xml)
    WpVersion.find(@uri, wp_content_dir, wp_plugins_dir, versions_xml)
  end

  def has_plugin?(name, version = nil)
    WpPlugin.new(
      @uri,
      name: name,
      version: version,
      wp_content_dir: wp_content_dir,
      wp_plugins_dir: wp_plugins_dir
    ).exists?
  end

  def wp_content_dir
    unless @wp_content_dir
      index_body = Browser.instance.get(@uri.to_s).body
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

  def default_wp_content_dir_exists?
    response = Browser.instance.get(@uri.merge('wp-content').to_s)
    hash = Digest::MD5.hexdigest(response.body)

    if WpTarget.valid_response_codes.include?(response.code)
      return true if hash != error_404_hash and hash != homepage_hash
    end

    false
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
    response_body = Browser.instance.get(debug_log_url(), headers: {'range' => 'bytes=0-700'}).body
    response_body[%r{\[[^\]]+\] PHP (?:Warning|Error|Notice):}] ? true : false
  end

  def debug_log_url
    @uri.merge("#{wp_content_dir()}/debug.log").to_s
  end

  # Script for replacing strings in wordpress databases
  # reveals databse credentials after hitting submit
  # http://interconnectit.com/124/search-and-replace-for-wordpress-databases/
  def search_replace_db_2_url
    @uri.merge('searchreplacedb2.php').to_s
  end

  def search_replace_db_2_exists?
    resp = Browser.instance.get(search_replace_db_2_url)
    resp.code == 200 && resp.body[%r{by interconnect}i]
  end

  # Should check wp-login.php if registration is enabled or not
  def registration_enabled?
    resp = Browser.instance.get(registration_url)
    # redirect only on non multi sites
    if resp.code == 302 and resp.headers_hash['location'] =~ /wp-login\.php\?registration=disabled/i
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
    is_multisite? ? @uri.merge('wp-signup.php') : @uri.merge('wp-login.php?action=register')
  end

  def is_multisite?
    unless @multisite
      # when multi site, there is no redirection or a redirect to the site itself
      # otherwise redirect to wp-login.php
      url = @uri.merge('wp-signup.php')
      resp = Browser.instance.get(url)
      if resp.code == 302 and resp.headers_hash['location'] =~ /wp-login\.php\?action=register/
        @multisite = false
      elsif resp.code == 302 and resp.headers_hash['location'] =~ /wp-signup\.php/
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
