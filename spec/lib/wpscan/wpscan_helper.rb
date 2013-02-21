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

require 'spec_helper'

require WPSCAN_LIB_DIR + '/wpscan_helper'

SPEC_FIXTURES_WPSCAN_DIR                = SPEC_FIXTURES_DIR + '/wpscan'
SPEC_FIXTURES_WPSCAN_MODULES_DIR        = SPEC_FIXTURES_WPSCAN_DIR + '/modules'
SPEC_FIXTURES_WPSCAN_WEB_SITE_DIR       = SPEC_FIXTURES_WPSCAN_DIR + '/web_site'
SPEC_FIXTURES_WPSCAN_WP_TARGET_DIR      = SPEC_FIXTURES_WPSCAN_DIR + '/wp_target'
SPEC_FIXTURES_WPSCAN_WPSCAN_OPTIONS_DIR = SPEC_FIXTURES_WPSCAN_DIR + '/wpscan_options'
SPEC_FIXTURES_WPSCAN_WP_THEME_DIR       = SPEC_FIXTURES_WPSCAN_DIR + '/wp_theme'
SPEC_FIXTURES_WPSCAN_WP_PLUGIN_DIR      = SPEC_FIXTURES_WPSCAN_DIR + '/wp_plugin'
SPEC_FIXTURES_WPSCAN_WP_VERSION_DIR     = SPEC_FIXTURES_WPSCAN_DIR + '/wp_version'

# This class is a HACK to simulate the WpTarget behavior in order
# to be able to test the modules independently
class WpScanModuleSpec
  attr_reader   :uri
  attr_accessor :error_404_hash, :homepage_hash, :wp_content_dir, :verbose

  def initialize(target_url)
    @uri = URI.parse(add_trailing_slash(add_http_protocol(target_url)))

    Browser::reset
    Browser.instance(
      config_file:   SPEC_FIXTURES_CONF_DIR + '/browser/browser.conf.json',
      cache_ttl: 0
    )
  end

  def url
    @uri.to_s
  end

  def login_url
    @uri.merge('wp-login.php').to_s
  end
end

