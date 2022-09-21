# frozen_string_literal: true

module WPScan
  module DB
    module DynamicFinders
      class Base
        # @return [ String ]
        def self.df_file
          @df_file ||= DB_DIR.join('dynamic_finders.yml').to_s
        end

        # @return [ Hash ]
        def self.all_df_data
          @all_df_data ||= if Gem::Version.new(Psych::VERSION) >= Gem::Version.new('4.0.0')
                             YAML.safe_load(File.read(df_file), permitted_classes: [Regexp])
                           else
                             YAML.safe_load(File.read(df_file), [Regexp])
                           end
        end

        # @return [ Array<Symbol> ]
        def self.allowed_classes
          # The Readme is not put in there as it's not a Real DF, but rather using the DF system
          # to get the list of potential filenames for a given slug
          @allowed_classes ||= %i[Comment Xpath HeaderPattern BodyPattern JavascriptVar QueryParameter ConfigParser]
        end

        # @param [ Symbol ] sym
        def self.method_missing(sym)
          super unless sym =~ /\A(passive|aggressive)_(.*)_finder_configs\z/i

          finder_class = Regexp.last_match[2].camelize.to_sym

          raise "#{finder_class} is not allowed as a Dynamic Finder" unless allowed_classes.include?(finder_class)

          finder_configs(
            finder_class,
            aggressive: Regexp.last_match[1] == 'aggressive'
          )
        end

        def self.respond_to_missing?(sym, *_args)
          sym =~ /\A(passive|aggressive)_(.*)_finder_configs\z/i
        end
      end
    end
  end
end
