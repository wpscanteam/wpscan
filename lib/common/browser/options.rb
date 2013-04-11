# encoding: UTF-8

class Browser
  module Options

    USER_AGENT_MODES = %w{ static semi-static random }

    attr_accessor :available_user_agents, :cache_ttl
    attr_reader   :basic_auth, :user_agent_mode, :proxy, :proxy_auth
    attr_writer   :user_agent

    # Sets the Basic Authentification credentials
    # Accepted format:
    #   login:password
    #   Basic base_64_encoded
    #
    # @param [ String ] auth
    #
    # @return [ void ]
    def basic_auth=(auth)
      if auth.index(':')
        @basic_auth = "Basic #{Base64.encode64(auth).chomp}"
      elsif auth =~ /\ABasic [a-zA-Z0-9=]+\z/
        @basic_auth = auth
      else
       raise 'Invalid basic authentication format, "login:password" or "Basic base_64_encoded" expected'
     end
    end

    # @return [ Integer ]
    def max_threads
      @max_threads || 1
    end

    def max_threads=(threads)
      if threads.is_a?(Integer) && threads > 0
        @max_threads = threads
        @hydra = Typhoeus::Hydra.new(max_concurrency: threads)
      else
        raise 'max_threads must be an Integer > 0'
      end
    end

    # Sets the user_agent_mode, which can be one of the following:
    #   static:      The UA is defined by the user, and will be the same in each requests
    #   semi-static: The UA is randomly chosen at the first request, and will not change
    #   random:      UA randomly chosen each request
    #
    # UA are from @available_user_agents
    #
    # @param [ String ] ua_mode
    #
    # @return [ void ]
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

    # @return [ String ] The user agent, according to the user_agent_mode
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

    # Sets the proxy
    # Accepted format:
    #   [protocol://]host:post
    #
    #  Supported protocols:
    #    Depends on the curl protocols, See curl --version
    #
    # @param [ String ] proxy
    #
    # @return [ void ]
    def proxy=(proxy)
      if proxy.index(':')
        @proxy = proxy
      else
        raise 'Invalid proxy format. Should be [protocol://]host:port.'
      end
    end

    # Sets the proxy credentials
    # Accepted format:
    #   username:password
    #   { proxy_username: username, :proxy_password: password }
    #
    # @param [ String ] auth
    #
    # @return [ void ]
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

    protected

    def invalid_proxy_auth_format
      'Invalid proxy auth format, expected username:password or {proxy_username: username, proxy_password: password}'
    end

    # Override with the options if they are set
    # @param [ Hash ] options
    #
    # @return [ void ]
    def override_config(options = {})
      options.each do |option, value|
        if value != nil and OPTIONS.include?(option)
          self.send(:"#{option}=", value)
        end
      end
    end

  end
end
