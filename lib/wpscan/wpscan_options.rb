# encoding: UTF-8

class WpscanOptions
  ACCESSOR_OPTIONS = [
    :batch,
    :enumerate_plugins,
    :enumerate_only_vulnerable_plugins,
    :enumerate_all_plugins,
    :enumerate_themes,
    :enumerate_only_vulnerable_themes,
    :enumerate_all_themes,
    :enumerate_timthumbs,
    :enumerate_usernames,
    :enumerate_usernames_range,
    :no_color,
    :log,
    :proxy,
    :proxy_auth,
    :threads,
    :url,
    :vhost,
    :wordlist,
    :force,
    :update,
    :verbose,
    :username,
    :usernames,
    :password,
    :follow_redirection,
    :wp_content_dir,
    :wp_plugins_dir,
    :help,
    :config_file,
    :cookie,
    :exclude_content_based,
    :basic_auth,
    :debug_output,
    :version,
    :user_agent,
    :random_agent,
    :cache_ttl,
    :request_timeout,
    :connect_timeout,
    :max_threads,
    :no_banner,
    :throttle,
    :disable_accept_header,
    :disable_referer,
    :cache_dir,
    :disable_tls_checks
  ]

  attr_accessor *ACCESSOR_OPTIONS

  def initialize
    ACCESSOR_OPTIONS.each do |option|
      instance_variable_set("@#{option}", nil)
    end
  end

  def url=(url)
    raise  Exception.new('Empty URL given') if url.nil? || url == ''

    url = Addressable::URI.parse(url).normalize.to_s unless url.ascii_only?

    @url = URI.parse(add_http_protocol(url)).to_s
  end

  def vhost=(vhost)
    @vhost = vhost
  end

  def threads=(threads)
    @threads = threads.is_a?(Integer) ? threads : threads.to_i
  end

  def wordlist=(wordlist)
    if File.exists?(wordlist) || wordlist == '-'
      @wordlist = wordlist
    else
      raise "The file #{wordlist} does not exist"
    end
  end

  def usernames=(file)
    fail "The file #{file} does not exist" unless File.exists?(file)

    @usernames = file
  end

  def proxy=(proxy)
    if proxy.index(':') == nil
      raise 'Invalid proxy format. Should be host:port.'
    else
      @proxy = proxy
    end
  end

  def proxy_auth=(auth)
    if auth.index(':') == nil
      raise 'Invalid proxy auth format, username:password expected'
    else
      @proxy_auth = auth
    end
  end

  def enumerate_plugins=(enumerate_plugins)
    if enumerate_plugins === true and (@enumerate_all_plugins === true or @enumerate_only_vulnerable_plugins === true)
      raise 'Please choose only one plugin enumeration option'
    else
      @enumerate_plugins = enumerate_plugins
    end
  end

  def enumerate_only_vulnerable_plugins=(enumerate_only_vulnerable_plugins)
    if enumerate_only_vulnerable_plugins === true and (@enumerate_all_plugins === true or @enumerate_plugins === true)
      raise 'Please choose only one plugin enumeration option'
    else
      @enumerate_only_vulnerable_plugins = enumerate_only_vulnerable_plugins
    end
  end

  def enumerate_all_plugins=(enumerate_all_plugins)
    if enumerate_all_plugins === true and (@enumerate_plugins === true or @enumerate_only_vulnerable_plugins === true)
      raise 'Please choose only one plugin enumeration option'
    else
      @enumerate_all_plugins = enumerate_all_plugins
    end
  end

  def enumerate_themes=(enumerate_themes)
    if enumerate_themes === true and (@enumerate_all_themes === true or @enumerate_only_vulnerable_themes === true)
      raise 'Please choose only one theme enumeration option'
    else
      @enumerate_themes = enumerate_themes
    end
  end

  def enumerate_only_vulnerable_themes=(enumerate_only_vulnerable_themes)
    if enumerate_only_vulnerable_themes === true and (@enumerate_all_themes === true or @enumerate_themes === true)
      raise 'Please choose only one theme enumeration option'
    else
      @enumerate_only_vulnerable_themes = enumerate_only_vulnerable_themes
    end
  end

  def enumerate_all_themes=(enumerate_all_themes)
    if enumerate_all_themes === true and (@enumerate_themes === true or @enumerate_only_vulnerable_themes === true)
      raise 'Please choose only one theme enumeration option'
    else
      @enumerate_all_themes = enumerate_all_themes
    end
  end

  def debug_output=(debug_output)
    Typhoeus::Config.verbose = debug_output
  end

  def has_options?
    !to_h.empty?
  end

  def random_agent=(useless)
    @user_agent = get_random_user_agent
  end

  # return Hash
  def to_h
    options = {}

    ACCESSOR_OPTIONS.each do |option|
      instance_variable = instance_variable_get("@#{option}")

      unless instance_variable.nil?
        options[:"#{option}"] = instance_variable
      end
    end
    options
  end

  # Will load the options from ARGV
  # return WpscanOptions
  def self.load_from_arguments
    wpscan_options = WpscanOptions.new

    if ARGV.length > 0
      WpscanOptions.get_opt_long.each do |opt, arg|
        wpscan_options.set_option_from_cli(opt, arg)
      end
    end

    wpscan_options
  end

  # string cli_option : --url, -u, --proxy etc
  # string cli_value : the option value
  def set_option_from_cli(cli_option, cli_value)

    if WpscanOptions.is_long_option?(cli_option)
      self.send(
          WpscanOptions.option_to_instance_variable_setter(cli_option),
          cli_value
      )
    elsif cli_option === '--enumerate' # Special cases
      # Default value if no argument is given
      cli_value = 'vt,tt,u,vp' if cli_value.length == 0

      enumerate_options_from_string(cli_value)
    else
      text = "Unknown option : #{cli_option}"
      text << " with value #{cli_value}" if (cli_value && !cli_value.empty?)
      raise text
    end
  end

  # Will set enumerate_* from the string value
  # IE : if value = vp => :enumerate_only_vulnerable_plugins will be set to true
  # multiple enumeration are possible : 'u,p' => :enumerate_usernames and :enumerate_plugins
  # Special case for usernames, a range is possible : u[1-10] will enumerate usernames from 1 to 10
  def enumerate_options_from_string(value)
    # Usage of self is mandatory because there are overridden setters

    value = value.split(',').map { |c| c.downcase }

    self.enumerate_only_vulnerable_plugins = true if value.include?('vp')

    self.enumerate_plugins = true if value.include?('p')

    self.enumerate_all_plugins = true if value.include?('ap')

    @enumerate_timthumbs = true if value.include?('tt')

    self.enumerate_only_vulnerable_themes = true if value.include?('vt')

    self.enumerate_themes = true if value.include?('t')

    self.enumerate_all_themes = true if value.include?('at')

    value.grep(/^u/) do |username_enum_value|
      @enumerate_usernames = true
      # Check for usernames range
      matches = %r{\[([\d]+)-([\d]+)\]}.match(username_enum_value)
      if matches
        @enumerate_usernames_range = (matches[1].to_i..matches[2].to_i)
      end
    end

  end

  protected
  # Even if a short option is given (IE : -u), the long one will be returned (IE : --url)
  def self.get_opt_long
    GetoptLong.new(
      ['--url', '-u', GetoptLong::REQUIRED_ARGUMENT],
      ['--vhost',GetoptLong::OPTIONAL_ARGUMENT],
      ['--enumerate', '-e', GetoptLong::OPTIONAL_ARGUMENT],
      ['--username', '-U', GetoptLong::REQUIRED_ARGUMENT],
      ['--usernames', GetoptLong::REQUIRED_ARGUMENT],
      ['--wordlist', '-w', GetoptLong::REQUIRED_ARGUMENT],
      ['--threads', '-t', GetoptLong::REQUIRED_ARGUMENT],
      ['--force', '-f', GetoptLong::NO_ARGUMENT],
      ['--user-agent', '-a', GetoptLong::REQUIRED_ARGUMENT],
      ['--random-agent', '-r', GetoptLong::NO_ARGUMENT],
      ['--help', '-h', GetoptLong::NO_ARGUMENT],
      ['--verbose', '-v', GetoptLong::NO_ARGUMENT],
      ['--proxy', GetoptLong::REQUIRED_ARGUMENT],
      ['--proxy-auth', GetoptLong::REQUIRED_ARGUMENT],
      ['--update', GetoptLong::NO_ARGUMENT],
      ['--follow-redirection', GetoptLong::NO_ARGUMENT],
      ['--wp-content-dir', GetoptLong::REQUIRED_ARGUMENT],
      ['--wp-plugins-dir', GetoptLong::REQUIRED_ARGUMENT],
      ['--config-file', '-c', GetoptLong::REQUIRED_ARGUMENT],
      ['--exclude-content-based', GetoptLong::REQUIRED_ARGUMENT],
      ['--basic-auth', GetoptLong::REQUIRED_ARGUMENT],
      ['--debug-output', GetoptLong::NO_ARGUMENT],
      ['--version', GetoptLong::NO_ARGUMENT],
      ['--cache-ttl', GetoptLong::REQUIRED_ARGUMENT],
      ['--request-timeout', GetoptLong::REQUIRED_ARGUMENT],
      ['--connect-timeout', GetoptLong::REQUIRED_ARGUMENT],
      ['--max-threads', GetoptLong::REQUIRED_ARGUMENT],
      ['--batch', GetoptLong::NO_ARGUMENT],
      ['--no-color', GetoptLong::NO_ARGUMENT],
      ['--cookie', GetoptLong::REQUIRED_ARGUMENT],
      ['--log', GetoptLong::OPTIONAL_ARGUMENT],
      ['--no-banner', GetoptLong::NO_ARGUMENT],
      ['--throttle', GetoptLong::REQUIRED_ARGUMENT],
      ['--disable-accept-header', GetoptLong::NO_ARGUMENT],
      ['--disable-referer', GetoptLong::NO_ARGUMENT],
      ['--cache-dir', GetoptLong::REQUIRED_ARGUMENT],
      ['--disable-tls-checks', GetoptLong::NO_ARGUMENT],
    )
  end

  def self.is_long_option?(option)
    ACCESSOR_OPTIONS.include?(:"#{WpscanOptions.clean_option(option)}")
  end

  # Will removed the '-' or '--' chars at the beginning of option
  # and replace any remaining '-' by '_'
  #
  # param string option
  # return string
  def self.clean_option(option)
    cleaned_option = option.gsub(/^--?/, '')
    cleaned_option.gsub(/-/, '_')
  end

  def self.option_to_instance_variable_setter(option)
    cleaned_option = WpscanOptions.clean_option(option)
    option_syms = ACCESSOR_OPTIONS.grep(%r{^#{cleaned_option}$})

    option_syms.length == 1 ? :"#{option_syms.at(0)}=" : nil
  end

end
