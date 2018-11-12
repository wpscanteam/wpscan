# Gems
# Believe it or not, active_support MUST be the first one,
# otherwise encoding issues can happen when using JSON format.
# Not kidding.
require 'active_support/all'
require 'cms_scanner'
require 'yajl/json_gem'
require 'addressable/uri'
# Standard Lib
require 'uri'
require 'time'
require 'readline'
require 'securerandom'

# Custom Libs
require 'wpscan/helper'
require 'wpscan/db'
require 'wpscan/version'
require 'wpscan/errors'
require 'wpscan/browser'
require 'wpscan/target'
require 'wpscan/finders'
require 'wpscan/controller'
require 'wpscan/controllers'
require 'wpscan/references'
require 'wpscan/vulnerable'
require 'wpscan/vulnerability'

Encoding.default_external = Encoding::UTF_8

# WPScan
module WPScan
  include CMSScanner

  APP_DIR = Pathname.new(__FILE__).dirname.join('..', 'app').expand_path
  DB_DIR  = File.join(Dir.home, '.wpscan', 'db')

  # Override, otherwise it would be returned as 'wp_scan'
  #
  # @return [ String ]
  def self.app_name
    'wpscan'
  end
end

require "#{WPScan::APP_DIR}/app"
