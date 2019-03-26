# frozen_string_literal: true

module WPScan
  module Finders
    module ConfigBackups
      # Config Backup finder
      class KnownFilenames < CMSScanner::Finders::Finder
        include CMSScanner::Finders::Finder::Enumerator

        # @param [ Hash ] opts
        # @option opts [ String ] :list
        # @option opts [ Boolean ] :show_progression
        #
        # @return [ Array<ConfigBackup> ]
        def aggressive(opts = {})
          found = []

          enumerate(potential_urls(opts), opts.merge(check_full_response: 200)) do |res|
            next unless res.body =~ /define/i && res.body !~ /<\s?html/i

            found << Model::ConfigBackup.new(res.request.url, found_by: DIRECT_ACCESS, confidence: 100)
          end

          found
        end

        # @param [ Hash ] opts
        # @option opts [ String ] :list Mandatory
        #
        # @return [ Hash ]
        def potential_urls(opts = {})
          urls = {}

          File.open(opts[:list]).each_with_index do |file, index|
            urls[target.url(file.chomp)] = index
          end

          urls
        end

        def create_progress_bar(opts = {})
          super(opts.merge(title: ' Checking Config Backups -'))
        end
      end
    end
  end
end
