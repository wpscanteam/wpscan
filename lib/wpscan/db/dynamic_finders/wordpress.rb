# frozen_string_literal: true

module WPScan
  module DB
    module DynamicFinders
      class Wordpress < Base
        # @return [ Hash ]
        def self.df_data
          @df_data ||= all_df_data['wordpress'] || {}
        end

        # @return [ Constant ]
        def self.version_finder_module
          Finders::WpVersion
        end

        # @return [ Array<Symbol> ]
        def self.allowed_classes
          @allowed_classes ||= %i[
            Comment Xpath HeaderPattern BodyPattern JavascriptVar QueryParameter WpItemQueryParameter
          ]
        end

        # @param [ Symbol ] finder_class
        # @param [ Boolean ] aggressive
        # @return [ Hash ]
        def self.finder_configs(finder_class, aggressive: false)
          configs = {}

          return configs unless allowed_classes.include?(finder_class)

          finders = if aggressive
                      df_data.reject { |_f, c| c['path'].nil? }
                    else
                      df_data.select { |_f, c| c['path'].nil? }
                    end

          finders.each do |finder_name, config|
            klass = config['class'] || finder_name

            next unless klass.to_sym == finder_class

            configs[finder_name] = config
          end

          configs
        end

        # @return [ Hash ]
        def self.versions_finders_configs
          @versions_finders_configs ||= df_data.select { |_finder_name, config| config.key?('version') }
        end

        def self.create_versions_finders
          versions_finders_configs.each do |finder_class, config|
            klass = config['class'] || finder_class

            # Instead of raising exceptions, skip unallowed/already defined finders
            # So that, when new DF configs are put in the .yml
            # users with old version of WPScan will still be able to scan blogs
            # when updating the DB but not the tool
            next if version_finder_module.constants.include?(finder_class.to_sym) ||
                    !allowed_classes.include?(klass.to_sym)

            version_finder_super_class(klass).create_child_class(version_finder_module, finder_class.to_sym, config)
          end
        end

        # @param [ String, Symbol ] klass
        # @return [ Constant ]
        def self.version_finder_super_class(klass)
          "WPScan::Finders::DynamicFinder::WpVersion::#{klass}".constantize
        end
      end
    end
  end
end
