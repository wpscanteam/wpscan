module WPScan
  class Error < StandardError
  end
end

require_relative 'errors/http'
require_relative 'errors/update'
require_relative 'errors/wordpress'
require_relative 'errors/xmlrpc'
