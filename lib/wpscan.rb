# frozen_string_literal: true

# Gems
# Believe it or not, active_support MUST be the first one,
# otherwise encoding issues can happen when using JSON format.
# Not kidding.
require 'active_support/all'
require 'typhoeus'
require 'nokogiri'
require 'yajl/json_gem'
require 'public_suffix'
require 'addressable/uri'
require 'get_process_mem'
require 'ruby-progressbar'
require 'opt_parse_validator'
# Standard Libs
require 'erb'
require 'uri'
require 'time'
require 'securerandom'
require 'resolv'
require 'fileutils'
require 'pathname'
require 'socket'
require 'timeout'
require 'xmlrpc/client'
# Monkey Patches/Fixes
require 'wpscan/typhoeus/response' # Adds Response#html and from_vuln_api?
require 'wpscan/typhoeus/hydra'    # https://github.com/typhoeus/typhoeus/issues/439
require 'wpscan/public_suffix/domain' # Adds Domain#match
require 'wpscan/numeric' # Adds Numeric#bytes_to_human
# Custom Libs
require 'wpscan/scan'
require 'wpscan/parsed_cli'
require 'wpscan/helper'
require 'wpscan/exit_code'
require 'wpscan/errors'
require 'wpscan/cache/typhoeus'
require 'wpscan/target'
require 'wpscan/browser'
require 'wpscan/version'
require 'wpscan/controller'
require 'wpscan/controllers'
require 'wpscan/formatter'
require 'wpscan/references'
require 'wpscan/finders'
require 'wpscan/vulnerability'
require 'wpscan/progressbar_null_output'
require 'wpscan/db'
require 'wpscan/vulnerable'

Encoding.default_external = Encoding::UTF_8

module WPScan
  APP_DIR = Pathname.new(__FILE__).dirname.join('..', 'app').expand_path

  # Avoid memory leak when using Hydra, see https://github.com/typhoeus/typhoeus/issues/562
  # Requests are still cached via the provided Cache system
  Typhoeus::Config.memoize = false

  # XDG support for DB_DIR
  # If the legacy path exists, it will be used. Otherwise, we'll use
  # $XDG_CACHE_HOME/wpscan/db or ~/.cache/wpscan/db when XDG_CACHE_HOME is unset.
  legacy_path = Pathname.new(Dir.home).join('.wpscan', 'db')
  xdg_path = Pathname.new(ENV['XDG_CACHE_HOME'] || Pathname.new(Dir.home).join('.cache')).join('wpscan', 'db')
  DB_DIR = legacy_path.exist? ? legacy_path : xdg_path

  Typhoeus.on_complete do |response|
    self.cached_requests += 1 if response.cached?

    next if response.cached?

    self.total_requests += 1
    self.total_data_sent += response.request_size
    self.total_data_received += response.size

    # Track HTTP status codes
    status_codes[response.code] += 1

    self.api_requests += 1 if response.respond_to?(:from_vuln_api?) && response.from_vuln_api?

    WPScan::Browser.instance.trottle!
  end

  class << self
    # The lowercase name of the scanner.
    # Mainly used in directory paths like the default cookie-jar file and
    # path to load the cli options from files.
    def app_name
      'wpscan'
    end

    def user_cache_dir
      Pathname.new(ENV['XDG_CACHE_HOME'] || Pathname.new(Dir.home).join('.cache')).join(app_name)
    end

    def cached_requests
      @@cached_requests ||= 0
    end

    def cached_requests=(value)
      @@cached_requests = value
    end

    def total_requests
      @@total_requests ||= 0
    end

    def total_requests=(value)
      @@total_requests = value
    end

    def total_data_sent
      @@total_data_sent ||= 0
    end

    def total_data_sent=(value)
      @@total_data_sent = value
    end

    def total_data_received
      @@total_data_received ||= 0
    end

    def total_data_received=(value)
      @@total_data_received = value
    end

    # Memory at the start of the scan (when Scan.new), in bytes.
    def start_memory
      @@start_memory ||= 0
    end

    def start_memory=(value)
      @@start_memory = value
    end

    def api_requests
      @@api_requests ||= 0
    end

    def api_requests=(value)
      @@api_requests = value
    end

    # Command line arguments used to start the scan
    def command_line
      @@command_line ||= ''
    end

    def command_line=(value)
      @@command_line = value

    # Tracking for HTTP status codes
    def status_codes
      @@status_codes ||= Hash.new(0)
    end

    # Reset status codes (mainly for testing)
    def reset_status_codes
      @@status_codes = Hash.new(0)
    end

    # Get top N status codes by frequency
    def top_status_codes(limit = 5)
      return {} if status_codes.empty?

      status_codes.sort_by { |_code, count| -count }.first(limit).to_h
    end

    # Determine if warning should be shown for concerning error codes
    def concerning_error_codes?
      return false if total_requests.zero?

      # Count errors excluding 404s (which are expected during enumeration)
      error_codes = status_codes.select { |code, _count| code >= 400 && code != 404 }
      total_errors = error_codes.values.sum

      # Warning conditions:
      # 1. More than 20% of requests are errors (excluding 404)
      # 2. More than 10 rate limit (429) responses
      # 3. More than 10 server errors (500-599)
      error_percentage = total_errors.to_f / total_requests
      rate_limit_count = status_codes[429] || 0
      server_errors = status_codes.select { |code, _| code >= 500 }.values.sum

      error_percentage > 0.2 || rate_limit_count > 10 || server_errors > 10
    end
  end
end

require "#{WPScan::APP_DIR}/app"
