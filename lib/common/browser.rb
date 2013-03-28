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

require 'common/typhoeus_cache'

class Browser
  @@instance = nil
  USER_AGENT_MODES = %w{ static semi-static random }

  ACCESSOR_OPTIONS = [
    :user_agent,
    :user_agent_mode,
    :available_user_agents,
    :proxy,
    :proxy_auth,
    :max_threads,
    :cache_ttl,
    :request_timeout,
    :basic_auth
  ]

  attr_reader :hydra, :config_file
  attr_accessor *ACCESSOR_OPTIONS

  def initialize(options = {})
    @config_file = options[:config_file] || CONF_DIR + '/browser.conf.json'
    options.delete(:config_file)

    load_config()

    if options.length > 0
      override_config_with_options(options)
    end

    @hydra = Typhoeus::Hydra.new(
      max_concurrency: @max_threads,
      #connecttimeout: @request_timeout
    )

    # TODO : add an argument for the cache dir instead of using a constant
    @cache = TyphoeusCache.new(CACHE_DIR + '/browser')

    @cache.clean

    Typhoeus::Config.cache = @cache
  end

  private_class_method :new

  def self.instance(options = {})
    unless @@instance
      @@instance = new(options)
    end
    @@instance
  end

  def self.reset
    @@instance = nil
  end

  def user_agent_mode=(ua_mode)
    ua_mode ||= 'static'

    if USER_AGENT_MODES.include?(ua_mode)
      @user_agent_mode = ua_mode
      # For semi-static user agent mode, the user agent has to
      # be nil the first time (it will be set with the getter)
      @user_agent = nil if ua_mode === 'semi-static'
    else
      raise "Unknow user agent mode : '#{ua_mode}'"
    end
  end

  # return the user agent, according to the user_agent_mode
  def user_agent
    case @user_agent_mode
    when 'semi-static'
      unless @user_agent
        @user_agent = @available_user_agents.sample
      end
    when 'random'
      @user_agent = @available_user_agents.sample
    end
    @user_agent
  end

  def max_threads=(max_threads)
    if max_threads.nil? or max_threads <= 0
      max_threads = 1
    end
    @max_threads = max_threads
  end

  def proxy_auth=(auth)
    unless auth.nil?
      if auth.is_a?(Hash) && auth.include?(:proxy_username) && auth.include?(:proxy_password)
        @proxy_auth = auth[:proxy_username] + ':' + auth[:proxy_password]
      elsif auth.is_a?(String) && auth.index(':') != nil
        @proxy_auth = auth
      else
        raise invalid_proxy_auth_format
      end
    end
  end

  def invalid_proxy_auth_format
    'Invalid proxy auth format, expected username:password or {proxy_username: username, proxy_password: password}'
  end

  # TODO reload hydra (if the .load_config is called on a browser object,
  # hydra will not have the new @max_threads and @request_timeout)
  def load_config(config_file = nil)
    @config_file = config_file || @config_file

    if File.symlink?(@config_file)
      raise "[ERROR] Config file is a symlink."
    else
      data = JSON.parse(File.read(@config_file))
    end

    ACCESSOR_OPTIONS.each do |option|
      option_name = option.to_s

      self.send(:"#{option_name}=", data[option_name])
    end
  end

  def get(url, params = {})
    run_request(
      forge_request(url, params.merge(method: :get))
    )
  end

  def post(url, params = {})
    run_request(
      forge_request(url, params.merge(method: :post))
    )
  end

  def get_and_follow_location(url, params = {})
    params[:maxredirs] ||= 2

    run_request(
      forge_request(url, params.merge(method: :get, followlocation: true))
    )
  end

  def forge_request(url, params = {})
    Typhoeus::Request.new(
      url.to_s,
      merge_request_params(params)
    )
  end

  def merge_request_params(params = {})
    params = Browser.append_params_header_field(
      params,
      'User-Agent',
      self.user_agent
    )

    if @proxy
      params = params.merge(proxy: @proxy)

      if @proxy_auth
        params = params.merge(proxyauth: @proxy_auth)
      end
    end

    if @basic_auth
      params = Browser.append_params_header_field(
        params,
        'Authorization',
        @basic_auth
      )
    end

    # Used to enable the cache system if :cache_ttl > 0
    unless params.has_key?(:cache_ttl)
      params = params.merge(cache_ttl: @cache_ttl)
    end

    # Disable SSL-Certificate checks
    params = params.merge(ssl_verifypeer: false)
    params = params.merge(ssl_verifyhost: 0)

    params
  end

  private

  # return Array
  def self.append_params_header_field(params = {}, field, field_value)
    if !params.has_key?(:headers)
      params = params.merge(:headers => { field => field_value })
    elsif !params[:headers].has_key?(field)
      params[:headers][field] = field_value
    end
    params
  end

  # return the response
  def run_request(request)
    @hydra.queue request
    @hydra.run
    request.response
  end

  # Override with the options if they are set
  def override_config_with_options(options)
    options.each do |option, value|
      if value != nil and ACCESSOR_OPTIONS.include?(option)
        self.send(:"#{option}=", value)
      end
    end
  end
end
