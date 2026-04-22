# frozen_string_literal: true

module CMSScanner
  class Target < WebSite
    module Server
      # Some IIS specific implementation
      module IIS
        # @param [ String ] path
        # @param [ Hash ] params The request params
        #
        # @return [ Symbol ] :IIS
        def server(_path = nil, _params = {})
          :IIS
        end

        # @param [ String ] path
        # @param [ Hash ] params The request params
        #
        # @return [ Boolean ] true if url(path) has the directory
        #                          listing enabled, false otherwise
        def directory_listing?(path = nil, params = {})
          res = NS::Browser.get(url(path), params)

          res.code == 200 && res.body =~ %r{<H1>#{uri.host} - /} ? true : false
        end
      end
    end
  end
end
