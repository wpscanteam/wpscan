# frozen_string_literal: true

module WPScan
  module Finders
    module DynamicFinder
      module Version
        # To be used as a base when creating
        # a dynamic finder to find the version of a WP Item (such as theme/plugin)
        class Finder < Finders::DynamicFinder::Finder
          protected

          # @param [ String ] number
          # @param [ Hash ] finding_opts
          # @return [ Model::Version ]
          def create_version(number, finding_opts)
            Model::Version.new(number, version_finding_opts(finding_opts))
          end

          # @param [ Hash ] opts
          # @retutn [ Hash ]
          def version_finding_opts(opts)
            opts[:found_by]   ||= found_by
            opts[:confidence] ||= self.class::CONFIDENCE

            opts
          end
        end
      end
    end
  end
end
