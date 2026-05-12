# frozen_string_literal: true

module WPScan
  module Finders
    module BackupFolders
      # Backup Folders finder
      class KnownLocations < Finders::Finder
        include WPScan::Finders::Finder::Enumerator

        # @return [ Array<Integer> ]
        def valid_response_codes
          @valid_response_codes ||= [200].freeze
        end

        # @param [ Hash ] opts
        # @option opts [ String ] :list
        # @option opts [ Boolean ] :show_progression
        #
        # @return [ Array<BackupFolder> ]
        def aggressive(opts = {})
          found = []

          enumerate(potential_urls(opts), opts.merge(check_full_response: valid_response_codes)) do |res|
            next if target.homepage_or_404?(res)

            # Only report if directory listing is enabled (makes finding actionable)
            next unless target.directory_listing?(res.request.url)

            found << Model::BackupFolder.new(
              res.request.url,
              confidence: 100, # Directory listing enabled - definite finding
              found_by: DIRECT_ACCESS,
              interesting_entries: target.directory_listing_entries(res.request.url)
            )
          end

          found
        end

        # @param [ Hash ] opts
        # @option opts [ String ] :list Mandatory
        #
        # @return [ Hash ]
        def potential_urls(opts = {})
          urls = {}
          content_base = target.content_dir || 'wp-content'

          File.open(opts[:list]) do |f|
            f.each_with_index do |line, index|
              path = line.chomp.strip
              next if path.empty? || path.start_with?('#')

              urls[target.url("#{content_base}/#{path}")] = index
            end
          end

          urls
        end

        def create_progress_bar(opts = {})
          super(opts.merge(title: ' Checking Backup Folders -'))
        end
      end
    end
  end
end
