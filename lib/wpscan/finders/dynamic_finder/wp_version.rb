# frozen_string_literal: true

module WPScan
  module Finders
    module DynamicFinder
      module WpVersion
        module Finder
          def create_version(number, finding_opts)
            return unless Model::WpVersion.valid?(number)

            Model::WpVersion.new(number, version_finding_opts(finding_opts))
          end
        end

        class BodyPattern < Finders::DynamicFinder::Version::BodyPattern
          include Finder
        end

        class Comment < Finders::DynamicFinder::Version::Comment
          include Finder
        end

        class HeaderPattern < Finders::DynamicFinder::Version::HeaderPattern
          include Finder
        end

        class JavascriptVar < Finders::DynamicFinder::Version::JavascriptVar
          include Finder
        end

        class QueryParameter < Finders::DynamicFinder::Version::QueryParameter
          include Finder

          # @return [ Hash ]
          def self.child_class_constants
            @child_class_constants ||= super().merge(PATTERN: /ver=(?<v>\d+\.[.\d]+)/i)
          end
        end

        # This one has been disabled from the DF.yml as it was causing FPs when a plugin had numerous
        # files matching a known WP version.
        class WpItemQueryParameter < QueryParameter
          def xpath
            @xpath ||=
              self.class::XPATH ||
              "//link[contains(@href,'#{target.plugins_dir}') or contains(@href,'#{target.themes_dir}')]/@href" \
              "|//script[contains(@src,'#{target.plugins_dir}') or contains(@src,'#{target.themes_dir}')]/@src"
          end

          def path_pattern
            @path_pattern ||= %r{
              (?:#{Regexp.escape(target.plugins_dir)}|#{Regexp.escape(target.themes_dir)})/
              [^/]+/
              .*\.(?:css|js)\z
            }ix
          end
        end

        class Xpath < WPScan::Finders::DynamicFinder::Version::Xpath
          include Finder
        end
      end
    end
  end
end
