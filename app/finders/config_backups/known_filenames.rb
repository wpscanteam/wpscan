# frozen_string_literal: true

module WPScan
  module Finders
    module ConfigBackups
      # Config Backup finder
      class KnownFilenames < CMSScanner::Finders::Finder
        include Finders::Finder::Enumerator

        # @param [ Hash ] opts
        # @option opts [ String ] :list
        # @option opts [ Boolean ] :show_progression
        #
        # @return [ Array<ConfigBackup> ]
        def aggressive(opts = {})
          found = []

          enumerate(potential_urls(opts), opts) do |res|
            found << Model::ConfigBackup.new(res.request.url, found_by: DIRECT_ACCESS, confidence: 100)
          end

          found
        end

        def valid_response?(res, _exclude_content = nil)
          return unless res.code == 200

          full_res = Browser.get(res.effective_url)

          full_res.body =~ /define/i && full_res.body !~ /<\s?html/i
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
