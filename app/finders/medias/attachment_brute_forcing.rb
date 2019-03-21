# frozen_string_literal: true

module WPScan
  module Finders
    module Medias
      # Medias Finder, see https://github.com/wpscanteam/wpscan/issues/172
      class AttachmentBruteForcing < CMSScanner::Finders::Finder
        include CMSScanner::Finders::Finder::Enumerator

        # @param [ Hash ] opts
        # @option opts [ Range ] :range Mandatory
        #
        # @return [ Array<Media> ]
        def aggressive(opts = {})
          found = []

          enumerate(target_urls(opts), opts) do |res|
            next unless res.code == 200

            found << Model::Media.new(res.effective_url, opts.merge(found_by: found_by, confidence: 100))
          end

          found
        end

        # @param [ Hash ] opts
        # @option opts [ Range ] :range Mandatory
        #
        # @return [ Hash ]
        def target_urls(opts = {})
          urls = {}

          opts[:range].each do |id|
            urls[target.uri.join("?attachment_id=#{id}").to_s] = id
          end

          urls
        end

        def create_progress_bar(opts = {})
          super(opts.merge(title: ' Brute Forcing Attachment IDs -'))
        end
      end
    end
  end
end
