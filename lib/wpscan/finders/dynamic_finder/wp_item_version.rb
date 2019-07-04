# frozen_string_literal: true

module WPScan
  module Finders
    module DynamicFinder
      module WpItemVersion
        class BodyPattern < Finders::DynamicFinder::Version::BodyPattern
        end

        class Comment < Finders::DynamicFinder::Version::Comment
        end

        class ConfigParser < Finders::DynamicFinder::Version::ConfigParser
        end

        class HeaderPattern < Finders::DynamicFinder::Version::HeaderPattern
        end

        class JavascriptVar < Finders::DynamicFinder::Version::JavascriptVar
        end

        class QueryParameter < Finders::DynamicFinder::Version::QueryParameter
          # @return [ Regexp ]
          def path_pattern
            # TODO: consider the target.blog.themes_dir if the target is a Theme (maybe implement a WpItem#item_dir ?)
            @path_pattern ||= %r{
              #{Regexp.escape(target.blog.plugins_dir)}/
              #{Regexp.escape(target.slug)}/
              (?:#{self.class::FILES.join('|')})\z
            }ix
          end

          def xpath
            @xpath ||= self.class::XPATH ||
                       "//link[contains(@href,'#{target.slug}')]/@href" \
                       "|//script[contains(@src,'#{target.slug}')]/@src"
          end
        end

        class Xpath < Finders::DynamicFinder::Version::Xpath
        end
      end
    end
  end
end
