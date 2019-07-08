# frozen_string_literal: true

require_relative 'plugin_version/readme'

module WPScan
  module Finders
    module PluginVersion
      # Plugin Version Finder
      class Base
        include CMSScanner::Finders::UniqueFinder

        # @param [ Model::Plugin ] plugin
        def initialize(plugin)
          finders << PluginVersion::Readme.new(plugin)

          create_and_load_dynamic_versions_finders(plugin)
        end

        # Create the dynamic version finders related to the plugin and register them
        #
        # @param [ Model::Plugin ] plugin
        def create_and_load_dynamic_versions_finders(plugin)
          DB::DynamicFinders::Plugin.create_versions_finders(plugin.slug).each do |finder|
            finders << finder.new(plugin)
          end
        end
      end
    end
  end
end
