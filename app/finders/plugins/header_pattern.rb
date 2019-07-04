# frozen_string_literal: true

module WPScan
  module Finders
    module Plugins
      # Plugins finder from Dynamic Finder 'HeaderPattern'
      class HeaderPattern < Finders::DynamicFinder::WpItems::Finder
        DEFAULT_CONFIDENCE = 30

        # @param [ Hash ] opts
        #
        # @return [ Array<Plugin> ]
        def passive(opts = {})
          found = []
          headers = target.homepage_res.headers

          return found if headers.empty?

          DB::DynamicFinders::Plugin.passive_header_pattern_finder_configs.each do |slug, configs|
            configs.each do |klass, config|
              next unless headers[config['header']] && headers[config['header']].to_s =~ config['pattern']

              found << Model::Plugin.new(
                slug,
                target,
                opts.merge(found_by: found_by(klass), confidence: config['confidence'] || DEFAULT_CONFIDENCE)
              )
            end
          end

          found
        end

        # @param [ Hash ] opts
        #
        # @return [ nil ]
        def aggressive(_opts = {})
          # None
        end
      end
    end
  end
end
