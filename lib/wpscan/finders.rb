# frozen_string_literal: true

require 'wpscan/finders/finder/wp_version/smart_url_checker'

require 'wpscan/finders/dynamic_finder/finder'
require 'wpscan/finders/dynamic_finder/wp_items/finder'
require 'wpscan/finders/dynamic_finder/version/finder'
require 'wpscan/finders/dynamic_finder/version/xpath'
require 'wpscan/finders/dynamic_finder/version/comment'
require 'wpscan/finders/dynamic_finder/version/header_pattern'
require 'wpscan/finders/dynamic_finder/version/body_pattern'
require 'wpscan/finders/dynamic_finder/version/javascript_var'
require 'wpscan/finders/dynamic_finder/version/query_parameter'
require 'wpscan/finders/dynamic_finder/version/config_parser'
require 'wpscan/finders/dynamic_finder/wp_item_version'
require 'wpscan/finders/dynamic_finder/wp_version'

module WPScan
  # Custom Finders
  module Finders
    include CMSScanner::Finders

    # Custom InterestingFindings
    module InterestingFindings
      include CMSScanner::Finders::InterestingFindings
    end
  end
end
