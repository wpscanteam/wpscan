# frozen_string_literal: true

module WPScan
  module Finders
    module DbExports
      # DB Exports finder
      class KnownLocations < CMSScanner::Finders::Finder
        include CMSScanner::Finders::Finder::Enumerator

        SQL_PATTERN = /(?:DROP|(?:UN)?LOCK|CREATE) TABLE|INSERT INTO/.freeze

        # @param [ Hash ] opts
        # @option opts [ String ] :list
        # @option opts [ Boolean ] :show_progression
        #
        # @return [ Array<DBExport> ]
        def aggressive(opts = {})
          found = []

          enumerate(potential_urls(opts), opts.merge(check_full_response: 200)) do |res|
            if res.effective_url.end_with?('.zip')
              next unless %r{\Aapplication/zip}i.match?(res.headers['Content-Type'])
            else
              next unless SQL_PATTERN.match?(res.body)
            end

            found << Model::DbExport.new(res.request.url, found_by: DIRECT_ACCESS, confidence: 100)
          end

          found
        end

        def full_request_params
          @full_request_params ||= { headers: { 'Range' => 'bytes=0-3000' } }
        end

        # @param [ Hash ] opts
        # @option opts [ String ] :list Mandatory
        #
        # @return [ Hash ]
        def potential_urls(opts = {})
          urls        = {}
          domain_name = (PublicSuffix.domain(target.uri.host) || target.uri.host)[/(^[\w|-]+)/, 1]

          File.open(opts[:list]).each_with_index do |path, index|
            path.gsub!('{domain_name}', domain_name)

            urls[target.url(path.chomp)] = index
          end

          urls
        end

        def create_progress_bar(opts = {})
          super(opts.merge(title: ' Checking DB Exports -'))
        end
      end
    end
  end
end
