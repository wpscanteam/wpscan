# frozen_string_literal: true

require 'ferrum'

module WPScan
  module BrowserAuthenticator
    # Characters that, if present in a cookie name or value, would corrupt the
    # serialized Cookie header. Per RFC 6265 these are forbidden in cookie-octets,
    # but a noncompliant IdP could still emit them.
    COOKIE_DELIMITERS = /[;,\s]/

    def self.authenticate(login_url)
      unless $stdin.tty?
        raise WPScan::Error::BrowserFailed,
              'SAML authentication needs an interactive terminal to wait for login, but stdin is not a TTY. ' \
              'Run wpscan from a real shell when using --expect-saml.'
      end

      cookies = run_login_session(login_url)

      raise WPScan::Error::SAMLAuthenticationFailed if cookies.nil? || cookies.empty?

      serialize_cookies(cookies)
    end

    # Drives the interactive browser session and returns the resulting cookie jar.
    # Translates Ferrum failures into BrowserFailed with a context-specific message.
    def self.run_login_session(login_url)
      browser = Ferrum::Browser.new(headless: false)

      puts 'SAML authentication needed. Log in via the browser window that just opened, then press enter.'
      browser.goto(login_url)
      gets # Waits for user input

      # Attempt an innocuous command to check if the browser is still responsive
      browser.current_url

      browser.cookies.all
    rescue Ferrum::BinaryNotFoundError, Ferrum::EmptyPathError => e
      raise WPScan::Error::BrowserFailed, chrome_not_found_message(e)
    rescue Ferrum::Error => e
      raise WPScan::Error::BrowserFailed,
            'The browser was closed or failed before SAML authentication could be completed ' \
            "(#{e.class}: #{e.message})."
    ensure
      browser.quit if browser&.process
    end

    def self.chrome_not_found_message(error)
      '--expect-saml requires Chrome or Chromium to be installed and available on PATH ' \
        '(install Chrome / Chromium, or point Ferrum at a binary via BROWSER_PATH). ' \
        "Underlying error: #{error.message}"
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
