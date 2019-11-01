# frozen_string_literal: true

module WPScan
  module Finders
    module DynamicFinder
      module WpItems
        # Not really a dynamic finder in itself (hence not a child class of DynamicFinder::Finder)
        # but will use the dynamic finder DB configs to find collections of
        # WpItems (such as Plugins and Themes)
        #
        # Also used to factorise some code used between such finders.
        # The #process_response should be implemented in each child class, or the
        # #passive and #aggressive overriden
        class Finder < CMSScanner::Finders::Finder
          # @return [ Hash ] The related dynamic finder passive configurations
          #                  for the current class (all its usefullness comes from child classes)
          def passive_configs
            # So far only the Plugins have dynamic finders so using DB:: DynamicFinders::Plugin
            # is ok. However, when Themes have some, will need to create other child classes for them

            method = "passive_#{self.class.to_s.demodulize.underscore}_finder_configs".to_sym

            DB::DynamicFinders::Plugin.public_send(method)
          end

          # @param [ Hash ] opts
          #
          # @return [ Array<Plugin>, Array<Theme> ]
          def passive(opts = {})
            found = []

            passive_configs.each do |slug, configs|
              configs.each do |klass, config|
                [target.homepage_res, target.error_404_res].each do |page_res|
                  item = process_response(opts, page_res, slug, klass, config)

                  if item.is_a?(Model::WpItem)
                    found << item
                    break # No need to check the other page if detected in the current
                  end
                end
              end
            end

            found
          end

          # @return [ Hash ] The related dynamic finder passive configurations
          #                  for the current class (all its usefullness comes from child classes)
          def aggressive_configs
            # So far only the Plugins have dynamic finders so using DB:: DynamicFinders::Plugin
            # is ok. However, when Themes have some, will need to create other child classes for them

            method = "aggressive_#{self.class.to_s.demodulize.underscore}_finder_configs".to_sym

            DB::DynamicFinders::Plugin.public_send(method)
          end

          # @param [ Hash ] opts
          #
          # @return [ Array<Plugin>, Array<Theme> ]
          def aggressive(_opts = {})
            # Disable this as it would make quite a lot of extra requests just to find plugins/themes
            # Kept the original method below for future implementation
          end

          # @param [ Hash ] opts
          #
          # @return [ Array<Plugin>, Array<Theme> ]
          def aggressive_(opts = {})
            found = []

            aggressive_configs.each do |slug, configs|
              configs.each do |klass, config|
                path     = aggressive_path(slug, config)
                response = Browser.get(target.url(path))

                item = process_response(opts, response, slug, klass, config)

                found << item if item.is_a?(Model::WpItem)
              end
            end

            found
          end

          # @param [ String ] slug
          # @param [ Hash ] config from the YAML file with he 'path' key
          #
          # @return [ String ] The path related to the aggresive configuration
          #                    ie config['path'] if it's an absolute path (like /file.txt)
          #                    or the path from inside the related plugin directory
          def aggressive_path(slug, config)
            return config['path'] if config['path'][0] == '/'

            # No need to set the correct plugins dir, it will be handled by target.url()
            "wp-content/plugins/#{slug}/#{config['path']}"
          end
        end
      end
    end
  end
end
