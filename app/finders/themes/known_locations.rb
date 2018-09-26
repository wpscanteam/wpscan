module WPScan
  module Finders
    module Themes
      # Known Locations Themes Finder
      class KnownLocations < CMSScanner::Finders::Finder
        include CMSScanner::Finders::Finder::Enumerator

        # @param [ Hash ] opts
        # @option opts [ String ] :list
        #
        # @return [ Array<Theme> ]
        def aggressive(opts = {})
          found = []

          enumerate(target_urls(opts), opts) do |res, slug|
            # TODO: follow the location (from enumerate()) and remove the 301 here ?
            # As a result, it might remove false positive due to redirection to the homepage
            next unless [200, 401, 403, 301].include?(res.code)

            found << WPScan::Theme.new(slug, target, opts.merge(found_by: found_by, confidence: 80))
          end

          found
        end

        # @param [ Hash ] opts
        # @option opts [ String ] :list
        #
        # @return [ Hash ]
        def target_urls(opts = {})
          slugs       = opts[:list] || DB::Themes.vulnerable_slugs
          urls        = {}
          themes_url  = target.url('wp-content/themes/')

          slugs.each do |slug|
            urls["#{themes_url}#{URI.encode(slug)}/"] = slug
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
