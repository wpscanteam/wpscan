# frozen_string_literal: true

module WPScan
  module Error
    class Standard < StandardError
    end
  end
end

require_relative 'errors/http'
require_relative 'errors/scan'
require_relative 'errors/enumeration'
require_relative 'errors/update'
require_relative 'errors/vuln_api'
require_relative 'errors/wordpress'
require_relative 'errors/wp_auth'
require_relative 'errors/xmlrpc'
require_relative 'errors/saml'
