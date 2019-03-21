# frozen_string_literal: true

module WPScan
  module Model
    include CMSScanner::Model
  end
end

require_relative 'models/interesting_finding'
require_relative 'models/wp_version'
require_relative 'models/xml_rpc'
require_relative 'models/wp_item'
require_relative 'models/timthumb'
require_relative 'models/media'
require_relative 'models/plugin'
require_relative 'models/theme'
require_relative 'models/config_backup'
require_relative 'models/db_export'
