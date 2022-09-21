# frozen_string_literal: true

module WPScan
  module Finders
    module DynamicFinder
      # To be used as a base when creating a dynamic finder
      class Finder < CMSScanner::Finders::Finder
        # @param [ Array ] args
        def self.child_class_constant(*args)
          args.each do |arg|
            if arg.is_a?(Hash)
              child_class_constants.merge!(arg)
            else
              child_class_constants[arg] = nil
            end
          end
        end

        # Needed to have inheritance of the @child_class_constants
        # If inheritance is not needed, then the #child_class_constant can be used in the class definition, ie
        #   child_class_constant :FILES, PATTERN: /aaa/i
        # @return [ Hash ]
        def self.child_class_constants
          @child_class_constants ||= { PATH: nil }
        end

        # @param [ Constant ] mod
        # @param [ Constant ] klass
        # @param [ Hash ] config
        def self.create_child_class(mod, klass, config)
          # Can't use the #child_class_constants directly in the Class.new(self) do; end below
          class_constants = child_class_constants

          mod.const_set(
            klass, Class.new(self) do
              class_constants.each do |key, value|
                const_set(key, config[key.downcase.to_s] || value)
              end
            end
          )
        end

        # This method has to be overriden in child classes
        #
        # @param [ Typhoeus::Response ] response
        # @param [ Hash ] opts
        # @return [ Mixed: nil, Object, Array ]
        def find(_response, _opts = {})
          raise NoMethodError
        end

        # @param [ Hash ] opts
        # @return [ Mixed ] See #find
        def passive(opts = {})
          return if self.class::PATH

          homepage_result = find(target.homepage_res, opts)

          unless homepage_result.nil? || (homepage_result.is_a?(Array) && homepage_result&.empty?)
            return homepage_result
          end

          find(target.error_404_res, opts)
        end

        # @param [ Hash ] opts
        # @return [ Mixed ] See #find
        def aggressive(opts = {})
          return unless self.class::PATH

          find(Browser.get(target.url(self.class::PATH)), opts)
        end
      end
    end
  end
end
