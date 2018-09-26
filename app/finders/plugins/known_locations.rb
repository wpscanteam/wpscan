module WPScan
  module Finders
    module Plugins
      # Known Locations Plugins Finder
      class KnownLocations < CMSScanner::Finders::Finder
        include CMSScanner::Finders::Finder::Enumerator

        # @param [ Hash ] opts
        # @option opts [ String ] :list
        #
        # @return [ Array<Plugin> ]
        def aggressive(opts = {})
          found = []

          enumerate(target_urls(opts), opts) do |res, slug|
            # TODO: follow the location (from enumerate()) and remove the 301 here ?
            # As a result, it might remove false positive due to redirection to the homepage
            next unless [200, 401, 403, 301].include?(res.code)

            found << WPScan::Plugin.new(slug, target, opts.merge(found_by: found_by, confidence: 80))
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
          plugins_url = target.plugins_url

          slugs.each do |slug|
            urls["#{plugins_url}#{URI.encode(slug)}/"] = slug
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
