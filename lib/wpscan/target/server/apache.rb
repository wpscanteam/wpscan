# frozen_string_literal: true

module CMSScanner
  class Target < WebSite
    module Server
      # Some Apche specific implementation
      module Apache
        # @param [ String ] path
        # @param [ Hash ] params The request params
        #
        # @return [ Symbol ] :Apache
        def server(_path = nil, _params = {})
          :Apache
        end

        # @param [ String ] path
        # @param [ Hash ] params The request params
        #
        # @return [ Array<String> ] The first level of directories/files listed,
        #                           or an empty array if none
        def directory_listing_entries(path = nil, params = {})
          super(path, params, 'td a')
        end
      end
    end
  end
end
