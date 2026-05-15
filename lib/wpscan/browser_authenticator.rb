# frozen_string_literal: true

require 'ferrum'

module WPScan
  module BrowserAuthenticator
    def self.authenticate(login_url)
      browser = Ferrum::Browser.new(headless: false)

      begin
        puts 'SAML authentication needed. Log in via the opened browser, then press enter.'
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

      cookies.map { |_name, cookie| "#{cookie.name}=#{cookie.value}" }.join('; ')
    end
  end
end
