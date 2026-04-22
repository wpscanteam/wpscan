# frozen_string_literal: true

module CMSScanner
  class Target < WebSite
    module Server
      # Generic Server methods
      module Generic
        # @param [ String ] path
        # @param [ Hash ] params The request params
        #
        # @return [ Symbol ] The detected remote server (:Apache, :IIS, :Nginx)
        def server(path = nil, params = {})
          headers = headers(path, params)

          return unless headers

          case headers[:server]
          when /\Aapache/i
            :Apache
          when /\AMicrosoft-IIS/i
            :IIS
          when /\Anginx/
            :Nginx
          end
        end

        # @param [ String ] path
        # @param [ Hash ] params The request params
        #
        # @return [ Hash ] The headers
        def headers(path = nil, params = {})
          # The HEAD method might be rejected by some servers ... maybe switch to GET ?
          NS::Browser.head(url(path), params).headers
        end

        # @param [ String ] path
        # @param [ Hash ] params The request params
        #
        # @return [ Boolean ] true if url(path) has the directory
        #                          listing enabled, false otherwise
        def directory_listing?(path = nil, params = {})
          res = NS::Browser.get(url(path), params)

          res.code == 200 && res.body.include?('<h1>Index of')
        end

        # @param [ String ] path
        # @param [ Hash ] params The request params
        # @param [ String ] selector
        # @param [ Regexp ] ignore
        #
        # @return [ Array<String> ] The first level of directories/files listed,
        #                           or an empty array if none
        def directory_listing_entries(path = nil, params = {}, selector = 'pre a', ignore = /parent directory/i)
          return [] unless directory_listing?(path, params)

          found = []

          NS::Browser.get(url(path), params).html.css(selector).each do |node|
            entry = node.text.to_s

            next if entry&.match?(ignore)

            found << entry
          end

          found
        end
      end
    end
  end
end
