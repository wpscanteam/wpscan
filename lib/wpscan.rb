# frozen_string_literal: true

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
require 'resolv'
# Monkey Patches/Fixes/Override
require 'wpscan/typhoeus/response' # Adds a from_vuln_api? method
# Custom Libs
require 'wpscan/helper'
require 'wpscan/db'
require 'wpscan/version'
require 'wpscan/errors'
require 'wpscan/parsed_cli'
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
  DB_DIR  = Pathname.new(Dir.home).join('.wpscan', 'db')

  Typhoeus.on_complete do |response|
    next if response.cached? || !response.from_vuln_api?

    self.api_requests += 1
  end

  # Override, otherwise it would be returned as 'wp_scan'
  #
  # @return [ String ]
  def self.app_name
    'wpscan'
  end

  # @return [ Integer ]
  def self.api_requests
    @@api_requests ||= 0
  end

  # @param [ Integer ] value
  def self.api_requests=(value)
    @@api_requests = value
  end
end

require "#{WPScan::APP_DIR}/app"
