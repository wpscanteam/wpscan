# frozen_string_literal: true

module WPScan
  module Finders
    module Plugins
      # URLs In Homepage Finder
      # Typically, the items detected from URLs like /wp-content/plugins/<slug>/
      class UrlsInHomepage < WPScan::Finders::Finder
        include WpItems::UrlsInPage

        # @param [ Hash ] opts
        #
        # @return [ Array<Plugin> ]
        def passive(opts = {})
          (items_from_links('plugins') + items_from_codes('plugins')).uniq.sort.map do |slug|
            Model::Plugin.new(slug, target, opts.merge(found_by: found_by, confidence: 80))
          end
        end

        # @return [ Typhoeus::Response ]
        def page_res
          @page_res ||= target.homepage_res
        end
      end
    end
  end
end
