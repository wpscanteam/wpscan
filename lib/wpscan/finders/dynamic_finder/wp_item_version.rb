module WPScan
  module Finders
    module DynamicFinder
      module WpItemVersion
        class BodyPattern < WPScan::Finders::DynamicFinder::Version::BodyPattern
        end

        class Comment < WPScan::Finders::DynamicFinder::Version::Comment
        end

        class ConfigParser < WPScan::Finders::DynamicFinder::Version::ConfigParser
        end

        class HeaderPattern < WPScan::Finders::DynamicFinder::Version::HeaderPattern
        end

        class JavascriptVar < WPScan::Finders::DynamicFinder::Version::JavascriptVar
        end

        class QueryParameter < WPScan::Finders::DynamicFinder::Version::QueryParameter
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

        class Xpath < WPScan::Finders::DynamicFinder::Version::Xpath
        end
      end
    end
  end
end
