# frozen_string_literal: true

module WPScan
  module Finders
    module Timthumbs
      # Known Locations Timthumbs Finder
      # Note: A vulnerable version, 2.8.13 can be found here:
      # https://github.com/GabrielGil/TimThumb/blob/980c3d6a823477761570475e8b83d3e9fcd2d7ae/timthumb.php
      class KnownLocations < CMSScanner::Finders::Finder
        include Finders::Finder::Enumerator

        # @param [ Hash ] opts
        # @option opts [ String ] :list Mandatory
        #
        # @return [ Array<Timthumb> ]
        def aggressive(opts = {})
          found = []

          enumerate(target_urls(opts), opts) do |res|
            found << Model::Timthumb.new(res.request.url, opts.merge(found_by: found_by, confidence: 100))
          end

          found
        end

        # @param [ Typhoeus::Response ] res
        # @param [ Regexp,nil ] exclude_content
        #
        # @return [ Boolean ]
        def valid_response?(res, _exclude_content = nil)
          return false unless res.code == 400

          full_res = Browser.get(res.effective_url, cache_ttl: 0)

          full_res.body =~ /no image specified/i ? true : false
        end

        # @param [ Hash ] opts
        # @option opts [ String ] :list Mandatory
        #
        # @return [ Hash ]
        def target_urls(opts = {})
          urls = {}

          File.open(opts[:list]).each_with_index do |path, index|
            urls[target.url(path.chomp)] = index
          end

          # Add potential timthumbs located in the main theme
          if target.main_theme
            main_theme_timthumbs_paths.each do |path|
              urls[target.main_theme.url(path)] = 1 # index not important there
            end
          end

          urls
        end

        def main_theme_timthumbs_paths
          %w[timthumb.php lib/timthumb.php inc/timthumb.php includes/timthumb.php
             scripts/timthumb.php tools/timthumb.php functions/timthumb.php]
        end

        def create_progress_bar(opts = {})
          super(opts.merge(title: ' Checking Known Locations -'))
        end
      end
    end
  end
end
