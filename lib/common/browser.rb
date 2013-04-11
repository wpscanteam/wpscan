# encoding: UTF-8

require 'common/typhoeus_cache'
require 'common/browser/actions'
require 'common/browser/options'

class Browser
  extend  Browser::Actions
  include Browser::Options

  OPTIONS = [
    :available_user_agents,
    :basic_auth,
    :cache_ttl,
    :max_threads,
    :user_agent,
    :user_agent_mode,
    :proxy,
    :proxy_auth
  ]

  @@instance = nil

  attr_reader :hydra, :config_file, :cache_dir

  # @param [ Hash ] options
  # @options
  def initialize(options = {})
    @config_file = options[:config_file] || CONF_DIR + '/browser.conf.json'
    @cache_dir   = options[:cache_dir]   || CACHE_DIR + '/browser'

    #options.delete(:config_file)

    load_config()

    #if options.length > 0
      override_config(options)
    #end

    @hydra = Typhoeus::Hydra.new(max_concurrency: self.max_threads)
    @cache = TyphoeusCache.new(@cache_dir)
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

  # TODO reload hydra (if the .load_config is called on a browser object,
  # hydra will not have the new @max_threads)
  def load_config(config_file = nil)
    @config_file = config_file || @config_file

    if File.symlink?(@config_file)
      raise "[ERROR] Config file is a symlink."
    else
      data = JSON.parse(File.read(@config_file))
    end

    OPTIONS.each do |option|
      option_name = option.to_s

      unless data[option_name].nil?
        self.send(:"#{option_name}=", data[option_name])
      end
    end
  end

  def forge_request(url, params = {})
    Typhoeus::Request.new(url, merge_request_params(params))
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
    params.merge!(ssl_verifypeer: false)
    params.merge!(ssl_verifyhost: 0)

    params.merge!(cookiejar: @cache_dir + '/cookie-jar')
    params.merge!(cookiefile: @cache_dir + '/cookie-jar')

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

end
