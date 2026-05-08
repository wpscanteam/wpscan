# frozen_string_literal: true

module WPScan
  module Model
    class WpItem
      # Fetches and exposes the public wordpress.org info API response for a
      # plugin or theme. The HTTP call is performed at most once per item.
      module WordpressOrgData
        # Timeout (in seconds) for the wordpress.org API lookup. Kept low so a
        # slow or unreachable wordpress.org does not noticeably stall the scan.
        WORDPRESS_ORG_API_TIMEOUT = 5

        # @return [ String, nil ] The wordpress.org API URL returning info for
        #   this item. Subclasses override this; nil disables the lookup.
        def wordpress_org_api_url
          nil
        end

        # @return [ Hash ] Empty hash if the item is not on wordpress.org or the
        #   lookup fails.
        def wordpress_org_data
          return @wordpress_org_data if defined?(@wordpress_org_data)

          @wordpress_org_data = fetch_wordpress_org_data
        end

        # Number of active installs as reported by the wordpress.org API.
        # See https://codex.wordpress.org/WordPress.org_API
        #
        # @return [ Integer, nil ]
        def active_installs
          wordpress_org_data['active_installs']
        end

        private

        # @return [ Hash ]
        def fetch_wordpress_org_data
          url = wordpress_org_api_url
          return {} unless url

          res = Browser.get(url, connecttimeout: WORDPRESS_ORG_API_TIMEOUT, timeout: WORDPRESS_ORG_API_TIMEOUT)
          return {} unless res.code == 200

          data = JSON.parse(res.body)
          data.is_a?(Hash) ? data : {}
        rescue StandardError
          {}
        end
      end

      include WordpressOrgData
    end
  end
end
