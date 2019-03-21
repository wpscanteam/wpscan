module WPScan
  module DB
    module DynamicFinders
      class Plugin < Base
        # @return [ Hash ]
        def self.db_data
          @db_data ||= super['plugins'] || {}
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

          db_data.each do |slug, finders|
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

          db_data.each do |slug, finders|
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

          # version_finder_module.constants.include? could be used here
          # however, it increases the memory allocated doing so.
          unless version_finder_modules.include?(constant_name)
            version_finder_module.const_set(constant_name, Module.new)

            version_finder_modules << constant_name
          end

          version_finder_module.const_get(constant_name)
        end

        # @return [ Array<Constant> ]
        def self.version_finder_modules
          @version_finder_modules ||= version_finder_module.constants
        end

        def self.create_versions_finders
          versions_finders_configs.each do |slug, finders|
            mod = maybe_create_module(slug)

            finders.each do |finder_class, config|
              klass = config['class'] || finder_class

              # Instead of raising exceptions, skip unallowed/already defined finders
              # So that, when new DF configs are put in the .yml
              # users with old version of WPScan will still be able to scan blogs
              # when updating the DB but not the tool
              next if mod.constants.include?(finder_class.to_sym) ||
                      !allowed_classes.include?(klass.to_sym)

              version_finder_super_class(klass).create_child_class(mod, finder_class.to_sym, config)
            end
          end
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
