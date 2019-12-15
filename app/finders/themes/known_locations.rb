# frozen_string_literal: true

module WPScan
  module Finders
    module Themes
      # Known Locations Themes Finder
      class KnownLocations < CMSScanner::Finders::Finder
        include CMSScanner::Finders::Finder::Enumerator

        # @return [ Array<Integer> ]
        def valid_response_codes
          @valid_response_codes ||= [200, 401, 403, 500].freeze
        end

        # @param [ Hash ] opts
        # @option opts [ String ] :list
        #
        # @return [ Array<Theme> ]
        def aggressive(opts = {})
          found = []

          enumerate(target_urls(opts), opts.merge(check_full_response: true)) do |res, slug|
            finding_opts = opts.merge(found_by: found_by,
                                      confidence: 80,
                                      interesting_entries: ["#{res.effective_url}, status: #{res.code}"])

            found << Model::Theme.new(slug, target, finding_opts)

            raise Error::ThemesThresholdReached if opts[:threshold].positive? && found.size >= opts[:threshold]
          end

          found
        end

        # @param [ Hash ] opts
        # @option opts [ String ] :list
        #
        # @return [ Hash ]
        def target_urls(opts = {})
          slugs = opts[:list] || DB::Themes.vulnerable_slugs
          urls  = {}

          slugs.each do |slug|
            urls[target.theme_url(slug)] = slug
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
