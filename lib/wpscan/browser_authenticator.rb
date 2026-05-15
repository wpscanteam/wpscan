# frozen_string_literal: true

require 'ferrum'

module WPScan
  module BrowserAuthenticator
    # Characters that, if present in a cookie name or value, would corrupt the
    # serialized Cookie header. Per RFC 6265 these are forbidden in cookie-octets,
    # but a noncompliant IdP could still emit them.
    COOKIE_DELIMITERS = /[;,\s]/

    def self.authenticate(login_url)
      raise WPScan::Error::BrowserFailed unless $stdin.tty?

      browser = Ferrum::Browser.new(headless: false)

      begin
        puts 'SAML authentication needed. Log in via the browser window that just opened, then press enter.'
        browser.goto(login_url)
        gets # Waits for user input

        # Attempt an innocuous command to check if the browser is still responsive
        browser.current_url

        cookies = browser.cookies.all
      rescue Ferrum::BrowserError, Ferrum::DeadBrowserError
        raise WPScan::Error::BrowserFailed
      ensure
        browser.quit if browser&.process
      end

      raise WPScan::Error::SAMLAuthenticationFailed if cookies.nil? || cookies.empty?

      serialize_cookies(cookies)
    end

    def self.serialize_cookies(cookies)
      cookies.map do |_name, cookie|
        raise WPScan::Error::SAMLAuthenticationFailed if cookie.name.match?(COOKIE_DELIMITERS) ||
                                                         cookie.value.to_s.match?(COOKIE_DELIMITERS)

        "#{cookie.name}=#{cookie.value}"
      end.join('; ')
    end
  end
end
