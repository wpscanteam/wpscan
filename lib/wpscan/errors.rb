module WPScan
  module Error
    include CMSScanner::Error

    class Standard < StandardError
    end
  end
end

require_relative 'errors/http'
require_relative 'errors/update'
require_relative 'errors/wordpress'
require_relative 'errors/xmlrpc'
