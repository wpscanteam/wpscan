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
  attr_accessor :error_404_hash

  def initialize(target_url)
    @uri = URI.parse(add_http_protocol(target_url))
    Browser.instance(
      :config_file   => SPEC_FIXTURES_CONF_DIR + '/browser/browser.conf.json',
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

