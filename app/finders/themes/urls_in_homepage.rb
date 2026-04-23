# frozen_string_literal: true

module WPScan
  module Finders
    module Themes
      # URLs In Homepage Finder
      class UrlsInHomepage < WPScan::Finders::Finder
        include WpItems::UrlsInPage

        # @param [ Hash ] opts
        #
        # @return [ Array<Theme> ]
        def passive(opts = {})
          (items_from_links('themes') + items_from_codes('themes')).uniq.sort.map do |slug|
            Model::Theme.new(slug, target, opts.merge(found_by: found_by, confidence: 80))
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
