# frozen_string_literal: true

module WPScan
  module DB
    module DynamicFinders
      class Base
        # @return [ String ]
        def self.db_file
          @db_file ||= DB_DIR.join('dynamic_finders.yml').to_s
        end

        # @return [ Hash ]
        def self.raw_db_data
          @raw_db_data ||= YAML.safe_load(File.read(db_file), [Regexp])
        end

        # @return [ Array<Symbol> ]
        def self.allowed_classes
          @allowed_classes ||= %i[Comment Xpath HeaderPattern BodyPattern JavascriptVar QueryParameter ConfigParser]
        end

        # @param [ Symbol ] sym
        def self.method_missing(sym)
          super unless sym =~ /\A(passive|aggressive)_(.*)_finder_configs\z/i

          finder_class = Regexp.last_match[2].camelize.to_sym

          raise "#{finder_class} is not allowed as a Dynamic Finder" unless allowed_classes.include?(finder_class)

          finder_configs(
            finder_class,
            Regexp.last_match[1] == 'aggressive'
          )
        end

        def self.respond_to_missing?(sym, *_args)
          sym =~ /\A(passive|aggressive)_(.*)_finder_configs\z/i
        end
      end
    end
  end
end
