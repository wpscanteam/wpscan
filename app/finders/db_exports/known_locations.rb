module WPScan
  module Finders
    module DbExports
      # DB Exports finder
      # See https://github.com/wpscanteam/wpscan-v3/issues/62
      class KnownLocations < CMSScanner::Finders::Finder
        include Finders::Finder::Enumerator

        SQL_PATTERN = /(?:DROP|(?:UN)?LOCK|CREATE) TABLE|INSERT INTO/.freeze

        # @param [ Hash ] opts
        # @option opts [ String ] :list
        # @option opts [ Boolean ] :show_progression
        #
        # @return [ Array<DBExport> ]
        def aggressive(opts = {})
          found = []

          enumerate(potential_urls(opts), opts) do |res|
            found << WPScan::DbExport.new(res.request.url, found_by: DIRECT_ACCESS, confidence: 100)
          end

          found
        end

        def valid_response?(res, _exclude_content = nil)
          return false unless res.code == 200

          return true if res.effective_url.end_with?('.zip') &&
                         res.headers['Content-Type'] =~ %r{\Aapplication/zip}i

          Browser.get(res.effective_url, headers: { 'Range' => 'bytes=0-3000' }).body =~ SQL_PATTERN ? true : false
        end

        # @param [ Hash ] opts
        # @option opts [ String ] :list Mandatory
        #
        # @return [ Hash ]
        def potential_urls(opts = {})
          urls        = {}
          domain_name = target.uri.host[/(^[\w|-]+)/, 1]

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
