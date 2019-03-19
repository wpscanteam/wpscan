module WPScan
  module Finders
    module Plugins
      # Known Locations Plugins Finder
      class KnownLocations < CMSScanner::Finders::Finder
        include Finders::Finder::Enumerator

        # @param [ Hash ] opts
        # @option opts [ String ] :list
        #
        # @return [ Array<Plugin> ]
        def aggressive(opts = {})
          found = []

          enumerate(target_urls(opts), opts) do |_res, slug|
            found << Model::Plugin.new(slug, target, opts.merge(found_by: found_by, confidence: 80))
          end

          found
        end

        # @param [ Hash ] opts
        # @option opts [ String ] :list
        #
        # @return [ Hash ]
        def target_urls(opts = {})
          slugs       = opts[:list] || DB::Plugins.vulnerable_slugs
          urls        = {}

          slugs.each do |slug|
            urls[target.plugin_url(slug)] = slug
          end

          urls
        end

        def create_progress_bar(opts = {})
          super(opts.merge(title: ' Checking Known Locations -'))
        end
      end
    end
  end
end
