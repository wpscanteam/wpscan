# frozen_string_literal: true

require_relative 'enumeration/cli_options'
require_relative 'enumeration/enum_methods'

module WPScan
  module Controller
    # Enumeration Controller
    class Enumeration < WPScan::Controller::Base
      def before_scan
        enum = ParsedCli.enumerate || {}

        # Check if vulnerable plugin/theme enumeration is requested without an API token
        return unless (enum[:vulnerable_plugins] || enum[:vulnerable_themes]) && DB::VulnApi.token.nil?

        raise Error::ApiTokenRequiredForVulnerableEnumeration
      end

      def run
        enum = ParsedCli.enumerate || {}

        resolve_list_enumerate_collisions(enum)

        enum_plugins if enum_plugins?(enum)
        enum_themes  if enum_themes?(enum)

        %i[timthumbs config_backups db_exports medias].each do |key|
          send(:"enum_#{key}") if enum.key?(key)
        end

        enum_users if enum_users?(enum)
      end
    end
  end
end
