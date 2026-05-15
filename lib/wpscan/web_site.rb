# frozen_string_literal: true

module WPScan
  # WebSite Implementation
  class WebSite
    attr_reader :uri, :opts

    # @param [ String ] site_url
    # @param [ Hash ] opts
    def initialize(site_url, opts = {})
      self.url = site_url
      @opts    = opts
    end

    def url=(site_url)
      new_url = site_url.dup

      # Add a trailing slash to the URL
      new_url << '/' if new_url[-1, 1] != '/'

      # Use the validator to ensure the URL has a correct format
      OptParseValidator::OptURL.new([]).validate(new_url)

      @uri = Addressable::URI.parse(new_url).normalize
    end

    # @param [ String ] path Optional path to merge with the uri
    #
    # @return [ String ]
    def url(path = nil)
      return @uri.to_s unless path

      @uri.join(Addressable::URI.encode(path).gsub('#', '%23')).to_s
    end

    # @return [ String ] The IP address of the target
    def ip
      @ip ||= IPSocket.getaddress(uri.host)
    rescue SocketError
      'Unknown'
    end

    attr_writer :homepage_res

    # @return [ Typhoeus::Response ]
    #
    # As webmock does not support redirects mocking, coverage is ignored
    # :nocov:
    def homepage_res
      @homepage_res ||= WPScan::Browser.get_and_follow_location(url)
    end
    # :nocov:

    # @return [ String ]
    def homepage_url
      @homepage_url ||= homepage_res.effective_url
    end

    # Discards the cached homepage response and URL so the next access refetches.
    # Used after mutating cookies/auth state mid-scan.
    def reset_homepage_cache!
      @homepage_res = nil
      @homepage_url = nil
    end

    # @return [ Typhoeus::Response ]
    def error_404_res
      @error_404_res ||= WPScan::Browser.get_and_follow_location(error_404_url)
    end

    # @return [ String ] The URL of an unlikely existant page
    def error_404_url
      @error_404_url ||= uri.join("#{Digest::MD5.hexdigest(rand(999_999).to_s)[0..6]}.html").to_s
    end

    # Checks if the remote website is up.
    #
    # @param [ String ] path
    #
    # @return [ Boolean ]
    def online?(path = nil)
      WPScan::Browser.get(url(path)).code.nonzero? ? true : false
    end

    # @param [ String ] path
    #
    # @return [ Boolean ]
    def http_auth?(path = nil)
      WPScan::Browser.get(url(path)).code == 401
    end

    # @param [ String ] path
    #
    # @return [ Boolean ]
    def access_forbidden?(path = nil)
      WPScan::Browser.get(url(path)).code == 403
    end

    # @param [ String ] path
    #
    # @return [ Boolean ]
    def proxy_auth?(path = nil)
      WPScan::Browser.get(url(path)).code == 407
    end

    # @param [ String ] url
    #
    # @return [ String ] The redirection url or nil
    #
    # As webmock does not support redirects mocking, coverage is ignored
    # :nocov:
    def redirection(url = nil)
      url ||= @uri.to_s

      return unless [301, 302].include?(WPScan::Browser.get(url).code)

      res = WPScan::Browser.get(url, followlocation: true, maxredirs: 10)

      res.effective_url == url ? nil : res.effective_url
    end
    # :nocov:

    # @return [ Hash ] The Typhoeus params to use to perform head requests
    def head_or_get_params
      @head_or_get_params ||= if [0, 405, 501].include?(WPScan::Browser.head(homepage_url).code)
                                { method: :get, maxfilesize: 1 }
                              else
                                { method: :head }
                              end
    end

    # Perform a HEAD request to the path provided, then if its response code
    # is in the array of codes given, a GET is done and the response returned. Otherwise the
    # HEAD response is returned.
    #
    # @param [ String ] path
    # @param [ Array<String> ] codes
    # @param [ Hash ] params The requests params
    # @option params [ Hash ] :head Request params for the HEAD
    # @option params [ hash ] :get Request params for the GET
    #
    # @return [ Typhoeus::Response ]
    def head_and_get(path, codes = [200], params = {})
      url_to_get  = url(path)
      head_params = (params[:head] || {}).merge(head_or_get_params)

      head_res = WPScan::Browser.forge_request(url_to_get, head_params).run

      codes.include?(head_res.code) ? WPScan::Browser.get(url_to_get, params[:get] || {}) : head_res
    end
  end
end
