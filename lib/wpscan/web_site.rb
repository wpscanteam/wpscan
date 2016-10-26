# encoding: UTF-8

require 'web_site/robots_txt'
require 'web_site/interesting_headers'

class WebSite
  include WebSite::RobotsTxt
  include WebSite::InterestingHeaders

  attr_reader :uri

  def initialize(site_url)
    self.url = site_url
  end

  def url=(url)
    @uri = URI.parse(add_trailing_slash(add_http_protocol(url)))
  end

  def url
    @uri.to_s
  end

  # Checks if the remote website has ssl errors
  def ssl_error?
    return false unless @uri.scheme == 'https'
    c = get_root_path_return_code
    # http://www.rubydoc.info/github/typhoeus/ethon/Ethon/Easy:return_code
    return (
      c == :ssl_connect_error ||
      c == :peer_failed_verification ||
      c == :ssl_certproblem ||
      c == :ssl_cipher ||
      c == :ssl_cacert ||
      c == :ssl_cacert_badfile ||
      c == :ssl_issuer_error ||
      c == :ssl_crl_badfile ||
      c == :ssl_engine_setfailed ||
      c == :ssl_engine_notfound
    )
  end

  def get_root_path_return_code
    Browser.get(@uri.to_s).return_code
  end

  # Checks if the remote website is up.
  def online?
    Browser.get(@uri.to_s).code != 0
  end

  def has_basic_auth?
    Browser.get(@uri.to_s).code == 401
  end

  def has_xml_rpc?
    response = Browser.get_and_follow_location(xml_rpc_url)
    response.body =~ %r{XML-RPC server accepts POST requests only}i
  end

  # See http://www.hixie.ch/specs/pingback/pingback-1.0#TOC2.3
  def xml_rpc_url
    unless @xmlrpc_url
      @xmlrpc_url = @uri.merge('xmlrpc.php').to_s
    end

    @xmlrpc_url
  end

  # See if the remote url returns 30x redirect
  # This method is recursive
  # Return a string with the redirection or nil
  def redirection(url = nil)
    redirection = nil
    url ||= @uri.to_s
    response = Browser.get(url)

    redirected_uri = URI.parse(add_trailing_slash(add_http_protocol(url)))
    if response.code == 301 || response.code == 302
      redirection = redirected_uri.merge(response.headers_hash['location']).to_s

      return redirection if url == redirection # prevents infinite loop

      # Let's check if there is a redirection in the redirection
      if other_redirection = redirection(redirection)
        redirection = other_redirection
      end
    end

    redirection
  end

  # Compute the MD5 of the page
  # Comments and scripts are deleted from the page to avoid cache generation details
  #
  # @param [ String, Typhoeus::Response ] page The url of the response of the page
  #
  # @return [ String ] The MD5 hash of the page
  def self.page_hash(page)
    page = Browser.get(page, { followlocation: true, cache_ttl: 0 }) unless page.is_a?(Typhoeus::Response)
    # remove comments
    page = page.body.gsub(/<!--.*?-->/m, '')
    # remove javascript stuff
    page = page.gsub(/<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/m, '')
    Digest::MD5.hexdigest(page)
  end

  def homepage_hash
    unless @homepage_hash
      @homepage_hash = WebSite.page_hash(@uri.to_s)
    end
    @homepage_hash
  end

  # Return the MD5 hash of a 404 page
  def error_404_hash
    unless @error_404_hash
      non_existant_page = Digest::MD5.hexdigest(rand(999_999_999).to_s) + '.html'
      @error_404_hash   = WebSite.page_hash(@uri.merge(non_existant_page).to_s)
    end
    @error_404_hash
  end

  # Will try to find the rss url in the homepage
  # Only the first one found is returned
  def rss_url
    homepage_body = Browser.get(@uri.to_s).body
    homepage_body[%r{<link .* type="application/rss\+xml" .* href="([^"]+)" />}, 1]
  end

  # Only the first 700 bytes are checked to avoid the download
  # of the whole file which can be very huge (like 2 Go)
  #
  # @param [ String ] log_url
  # @param [ RegEx ] pattern
  #
  # @return [ Boolean ]
  def self.has_log?(log_url, pattern)
    log_body = Browser.get(log_url, headers: {'range' => 'bytes=0-700'}).body
    log_body[pattern] ? true : false
  end
end
