# frozen_string_literal: true

module CMSScanner
  class Target < WebSite
    module Server
      # Some Nginx specific implementation
      module Nginx
        # @param [ String ] path
        # @param [ Hash ] params The request params
        #
        # @return [ Symbol ] :Nginx
        def server(_path = nil, _params = {})
          :Nginx
        end

        # @param [ String ] path
        # @param [ Hash ] params The request params
        #
        # @return [ Array<String> ] The first level of directories/files listed,
        #                           or an empty array if none
        def directory_listing_entries(path = nil, params = {})
          super(path, params, 'pre a', /\A\.\./i)
        end
      end
    end
  end
end
