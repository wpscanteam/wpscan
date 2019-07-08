# frozen_string_literal: true

module WPScan
  module DB
    module DynamicFinders
      class Plugin < Base
        # @return [ Hash ]
        def self.df_data
          @df_data ||= all_df_data['plugins'] || {}
        end

        def self.version_finder_module
          Finders::PluginVersion
        end

        # @param [ Symbol ] finder_class
        # @param [ Boolean ] aggressive
        # @return [ Hash ]
        def self.finder_configs(finder_class, aggressive = false)
          configs = {}

          return configs unless allowed_classes.include?(finder_class)

          df_data.each do |slug, finders|
            # Quite sure better can be done with some kind of logic statement in the select
            fs = if aggressive
                   finders.reject { |_f, c| c['path'].nil? }
                 else
                   finders.select { |_f, c| c['path'].nil? }
                 end

            fs.each do |finder_name, config|
              klass = config['class'] || finder_name

              next unless klass.to_sym == finder_class

              configs[slug] ||= {}
              configs[slug][finder_name] = config
            end
          end

          configs
        end

        # @return [ Hash ]
        def self.versions_finders_configs
          return @versions_finders_configs if @versions_finders_configs

          @versions_finders_configs = {}

          df_data.each do |slug, finders|
            finders.each do |finder_name, config|
              next unless config.key?('version')

              @versions_finders_configs[slug] ||= {}
              @versions_finders_configs[slug][finder_name] = config
            end
          end

          @versions_finders_configs
        end

        # @param [ String ] slug
        # @return [ Constant ]
        def self.maybe_create_module(slug)
          # What about slugs such as js_composer which will be done as JsComposer, just like js-composer
          constant_name = classify_slug(slug)

          unless version_finder_module.constants.include?(constant_name)
            version_finder_module.const_set(constant_name, Module.new)
          end

          version_finder_module.const_get(constant_name)
        end

        # Create the dynamic finders related to the given slug, and return the created classes
        #
        # @param [ String ] slug
        #
        # @return [ Array<Class> ] The created classes
        def self.create_versions_finders(slug)
          created = []
          mod     = maybe_create_module(slug)

          versions_finders_configs[slug]&.each do |finder_class, config|
            klass = config['class'] || finder_class

            # Instead of raising exceptions, skip unallowed/already defined finders
            # So that, when new DF configs are put in the .yml
            # users with old version of WPScan will still be able to scan blogs
            # when updating the DB but not the tool

            next unless allowed_classes.include?(klass.to_sym)

            created << if mod.constants.include?(finder_class.to_sym)
                         mod.const_get(finder_class.to_sym)
                       else
                         version_finder_super_class(klass).create_child_class(mod, finder_class.to_sym, config)
                       end
          end

          created
        end

        # The idea here would be to check if the class exist in
        # the Finders::DynamicFinders::Plugins/Themes::klass or WpItemVersion::klass
        # and return the related constant when one has been found.
        #
        # So far, the Finders::DynamicFinders::WPItemVersion is enought
        # as nothing else is used
        #
        # @param [ String, Symbol ] klass
        # @return [ Constant ]
        def self.version_finder_super_class(klass)
          "WPScan::Finders::DynamicFinder::WpItemVersion::#{klass}".constantize
        end
      end
    end
  end
end
