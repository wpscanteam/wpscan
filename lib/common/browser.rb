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
    :proxy_auth,
    :request_timeout,
    :connect_timeout
  ]

  @@instance = nil

  attr_reader :hydra, :config_file, :cache_dir

  # @param [ Hash ] options
  #
  # @return [ Browser ]
  def initialize(options = {})
    @config_file = options[:config_file] || CONF_DIR + '/browser.conf.json'
    @cache_dir   = options[:cache_dir]   || CACHE_DIR + '/browser'

    load_config
    override_config(options)

    unless @hydra
      @hydra = Typhoeus::Hydra.new(max_concurrency: self.max_threads)
    end

    @cache = TyphoeusCache.new(@cache_dir)
    @cache.clean

    Typhoeus::Config.cache = @cache
  end

  private_class_method :new

  # @param [ Hash ] options
  #
  # @return [ Browser ]
  def self.instance(options = {})
    unless @@instance
      @@instance = new(options)
    end
    @@instance
  end

  def self.reset
    @@instance = nil
  end

  #
  # If an option was set but is not in the new config_file
  # it's value is kept
  #
  # @param [ String ] config_file
  #
  # @return [ void ]
  def load_config(config_file = nil)
    @config_file = config_file || @config_file

    if File.symlink?(@config_file)
      raise '[ERROR] Config file is a symlink.'
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

  # @param [ String ] url
  # @param [ Hash ] params
  #
  # @return [ Typhoeus::Request ]
  def forge_request(url, params = {})
    Typhoeus::Request.new(url, merge_request_params(params))
  end

  # @param [ Hash ] params
  #
  # @return [ Hash ]
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

    params.merge!(timeout: @request_timeout) if @request_timeout
    params.merge!(connecttimeout: @connect_timeout) if @connect_timeout

    # Used to enable the cache system if :cache_ttl > 0
    params.merge!(cache_ttl: @cache_ttl) unless params.has_key?(:cache_ttl)

    # Prevent infinite self redirection
    params.merge!(maxredirs: 3) unless params.has_key?(:maxredirs)

    # Disable SSL-Certificate checks
    params.merge!(ssl_verifypeer: false)
    params.merge!(ssl_verifyhost: 0)

    params.merge!(cookiejar: @cache_dir + '/cookie-jar')
    params.merge!(cookiefile: @cache_dir + '/cookie-jar')

    params
  end

  private

  # @param [ Hash ] params
  # @param [ String ] field
  # @param [ Mixed ] field_value
  #
  # @return [ Array ]
  def self.append_params_header_field(params = {}, field, field_value)
    if !params.has_key?(:headers)
      params = params.merge(:headers => { field => field_value })
    elsif !params[:headers].has_key?(field)
      params[:headers][field] = field_value
    end
    params
  end

end
