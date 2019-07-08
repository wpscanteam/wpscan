# frozen_string_literal: true

require_relative 'enumeration/cli_options'
require_relative 'enumeration/enum_methods'

module WPScan
  module Controller
    # Enumeration Controller
    class Enumeration < CMSScanner::Controller::Base
      def run
        enum = ParsedCli.enumerate || {}

        enum_plugins if enum_plugins?(enum)
        enum_themes  if enum_themes?(enum)

        %i[timthumbs config_backups db_exports medias].each do |key|
          send("enum_#{key}".to_sym) if enum.key?(key)
        end

        enum_users if enum_users?(enum)
      end
    end
  end
end
