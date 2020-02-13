# frozen_string_literal: true

module WPScan
  module Finders
    module MainTheme
      # From the CSS style in the homepage
      class CssStyleInHomepage < CMSScanner::Finders::Finder
        include Finders::WpItems::UrlsInPage # To have the item_code_pattern method available here

        def create_theme(slug, style_url, opts)
          Model::Theme.new(
            slug,
            target,
            opts.merge(found_by: found_by, confidence: 70, style_url: style_url)
          )
        end

        def passive(opts = {})
          passive_from_css_href(target.homepage_res, opts) || passive_from_style_code(target.homepage_res, opts)
        end

        def passive_from_css_href(res, opts)
          target.in_scope_uris(res, '//link/@href[contains(., "style.css")]') do |uri|
            next unless uri.path =~ %r{/themes/([^\/]+)/style.css\z}i

            return create_theme(Regexp.last_match[1], uri.to_s, opts)
          end
          nil
        end

        def passive_from_style_code(res, opts)
          res.html.css('style').each do |tag|
            code = tag.text.to_s
            next if code.empty?

            next unless code =~ %r{#{item_code_pattern('themes')}\\?/style\.css[^"'\( ]*}i

            return create_theme(Regexp.last_match[1], Regexp.last_match[0].strip, opts)
          end
          nil
        end
      end
    end
  end
end
