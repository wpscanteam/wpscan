# frozen_string_literal: true

module WPScan
  module Finders
    module MainTheme
      # URLs In Homepage Finder
      class UrlsInHomepage < CMSScanner::Finders::Finder
        include WpItems::UrlsInPage

        # @param [ Hash ] opts
        #
        # @return [ Array<Theme> ]
        def passive(opts = {})
          found = []

          slugs = items_from_links('themes', uniq: false) + items_from_codes('themes', uniq: false)

          slugs.each_with_object(Hash.new(0)) { |slug, counts| counts[slug] += 1 }.each do |slug, occurences|
            found << Model::Theme.new(slug, target, opts.merge(found_by: found_by, confidence: 2 * occurences))
          end

          found
        end

        # @return [ Typhoeus::Response ]
        def page_res
          @page_res ||= target.homepage_res
        end
      end
    end
  end
end
