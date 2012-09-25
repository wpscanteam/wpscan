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

class Browser
  @@instance = nil
  USER_AGENT_MODES = %w{ static semi-static random }

  ACCESSOR_OPTIONS = [
      :user_agent,
      :user_agent_mode,
      :available_user_agents,
      :proxy,
      :max_threads,
      :cache_timeout,
      :request_timeout
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

    @hydra = Typhoeus::Hydra.new(:max_concurrency => @max_threads, :timeout => @request_timeout)
    # TODO : add an option for the cache dir instead of using a constant
    @cache = CacheFileStore.new(CACHE_DIR + '/browser')

    @cache.clean

    # might be in CacheFileStore
    setup_cache_handlers
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
    ua_mode ||= "static"

    if USER_AGENT_MODES.include?(ua_mode)
      @user_agent_mode = ua_mode
      # For semi-static user agent mode, the user agent has to be nil the first time (it will be set with the getter)
      @user_agent = nil if ua_mode === "semi-static"
    else
      raise "Unknow user agent mode : '#{ua_mode}'"
    end
  end

  # return the user agent, according to the user_agent_mode
  def user_agent
    case @user_agent_mode
      when "semi-static"
        unless @user_agent
          @user_agent = @available_user_agents.sample
        end
      when "random"
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

  # TODO reload hydra (if the .load_config is called on a browser object, hydra will not have the new @max_threads and @request_timeout)
  def load_config(config_file = nil)
    @config_file = config_file || @config_file

    data = JSON.parse(File.read(@config_file))

    ACCESSOR_OPTIONS.each do |option|
      option_name = option.to_s

      self.send(:"#{option_name}=", data[option_name])
    end
  end

  def setup_cache_handlers
    @hydra.cache_setter do |request|
      @cache.write_entry(
          Browser.generate_cache_key_from_request(request),
          request.response,
          request.cache_timeout
      )
    end

    @hydra.cache_getter do |request|
      @cache.read_entry(Browser.generate_cache_key_from_request(request)) rescue nil
    end
  end

  private :setup_cache_handlers

  def get(url, params = {})
    run_request(
        forge_request(url, params.merge(:method => :get))
    )
  end

  def post(url, params = {})
    run_request(
        forge_request(url, params.merge(:method => :post))
    )
  end

  def forge_request(url, params = {})
    Typhoeus::Request.new(
        url.to_s,
        merge_request_params(params)
    )
  end

  def merge_request_params(params = {})
    if @proxy
      params = params.merge(:proxy => @proxy)
    end

    unless params.has_key?(:disable_ssl_host_verification)
      params = params.merge(:disable_ssl_host_verification => true)
    end

    unless params.has_key?(:disable_ssl_peer_verification)
      params = params.merge(:disable_ssl_peer_verification => true)
    end

    if !params.has_key?(:headers)
      params = params.merge(:headers => {'user-agent' => self.user_agent})
    elsif !params[:headers].has_key?('user-agent')
      params[:headers]['user-agent'] = self.user_agent
    end

    # Used to enable the cache system if :cache_timeout > 0
    unless params.has_key?(:cache_timeout)
      params = params.merge(:cache_timeout => @cache_timeout)
    end

    params
  end

  private

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

  # The Typhoeus::Request.cache_key only hash the url :/
  # this one will include the params
  # TODO : include also the method (:get, :post, :any)
  def self.generate_cache_key_from_request(request)
    cache_key = request.cache_key

    if request.params
      cache_key = Digest::SHA1.hexdigest("#{cache_key}-#{request.params.hash}")
    end

    cache_key
  end
end
