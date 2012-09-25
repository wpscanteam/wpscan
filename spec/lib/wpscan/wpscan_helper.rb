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

require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

require WPSCAN_LIB_DIR + '/wpscan_helper'

SPEC_FIXTURES_WPSCAN_DIR = SPEC_FIXTURES_DIR + '/wpscan'
SPEC_FIXTURES_WPSCAN_MODULES_DIR = SPEC_FIXTURES_WPSCAN_DIR + '/modules'
SPEC_FIXTURES_WPSCAN_WP_TARGET_DIR = SPEC_FIXTURES_WPSCAN_DIR + '/wp_target'
SPEC_FIXTURES_WPSCAN_WPSCAN_OPTIONS_DIR = SPEC_FIXTURES_WPSCAN_DIR + '/wpscan_options'
SPEC_FIXTURES_WPSCAN_WP_THEME_DIR = SPEC_FIXTURES_WPSCAN_DIR + '/wp_theme'
SPEC_FIXTURES_WPSCAN_WP_PLUGIN_DIR = SPEC_FIXTURES_WPSCAN_DIR + '/wp_plugin'
SPEC_FIXTURES_WPSCAN_WP_VERSION_DIR = SPEC_FIXTURES_WPSCAN_DIR + '/wp_version'

class WpScanModuleSpec
  attr_reader :uri
  attr_accessor :error_404_hash, :wp_content_dir, :verbose

  def initialize(target_url)
    @uri = URI.parse(add_http_protocol(target_url))
    Browser.instance(
        :config_file => SPEC_FIXTURES_CONF_DIR + '/browser/browser.conf.json',
        :cache_timeout => 0
    )
  end

  def url
    @uri.to_s
  end

  def login_url
    @uri.merge("wp-login.php").to_s
  end
end

