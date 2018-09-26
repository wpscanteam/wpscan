module WPScan
  module Finders
    module DbExports
      # DB Exports finder
      # See https://github.com/wpscanteam/wpscan-v3/issues/62
      class KnownLocations < CMSScanner::Finders::Finder
        include CMSScanner::Finders::Finder::Enumerator

        # @param [ Hash ] opts
        # @option opts [ String ] :list
        # @option opts [ Boolean ] :show_progression
        #
        # @return [ Array<DBExport> ]
        def aggressive(opts = {})
          found = []

          enumerate(potential_urls(opts), opts) do |res|
            next unless res.code == 200 && res.body =~ /INSERT INTO/

            found << WPScan::DbExport.new(res.request.url, found_by: DIRECT_ACCESS, confidence: 100)
          end

          found
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
