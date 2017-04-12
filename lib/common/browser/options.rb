# encoding: UTF-8

class Browser
  module Options

    attr_accessor :request_timeout, :connect_timeout, :user_agent, :disable_accept_header, :disable_referer, :disable_tls_checks
    attr_reader   :basic_auth, :cache_ttl, :proxy, :proxy_auth, :throttle

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
        raise "Invalid basic authentication format, \"login:password\" or \"Basic base_64_encoded\" expected. Your input: #{auth}"
     end
    end

    def cache_ttl=(ttl)
      @cache_ttl = ttl.to_i
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

    # Sets the request timeout
    # @param [ Integer ] timeout Timeout in ms
    #
    # @return [ void ]
    def request_timeout=(timeout)
      @request_timeout = timeout.to_i
    end

    # Sets the connect timeout
    # @param [ Integer ] timeout Timeout in ms
    #
    # @return [ void ]
    def connect_timeout=(timeout)
      @connect_timeout = timeout.to_i
    end

    # @param [ String, Integer ] throttle
    def throttle=(throttle)
      @throttle = throttle.to_i.abs / 1000.0
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
