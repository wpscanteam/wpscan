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

          load_specific_finders(plugin)
        end

        # Load the finders associated with the plugin
        #
        # @param [ Model::Plugin ] plugin
        def load_specific_finders(plugin)
          module_name = plugin.classify

          return unless Finders::PluginVersion.constants.include?(module_name)

          mod = Finders::PluginVersion.const_get(module_name)

          mod.constants.each do |constant|
            c = mod.const_get(constant)

            next unless c.is_a?(Class)

            finders << c.new(plugin)
          end
        end
      end
    end
  end
end
