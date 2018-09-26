module WPScan
  module Finders
    module WpItems
      # URLs In Homepage Module to use in plugins & themes finders
      module URLsInHomepage
        # @param [ String ] type plugins / themes
        # @param [ Boolean ] uniq Wether or not to apply the #uniq on the results
        #
        # @return [Array<String> ] The plugins/themes detected in the href, src attributes of the homepage
        def items_from_links(type, uniq = true)
          found = []

          target.in_scope_urls(target.homepage_res) do |url|
            next unless url =~ item_attribute_pattern(type)

            found << Regexp.last_match[1]
          end

          uniq ? found.uniq.sort : found.sort
        end

        # @param [ String ] type plugins / themes
        # @param [ Boolean ] uniq Wether or not to apply the #uniq on the results
        #
        # @return [Array<String> ] The plugins/themes detected in the javascript/style of the homepage
        def items_from_codes(type, uniq = true)
          found = []

          target.homepage_res.html.css('script,style').each do |tag|
            code = tag.text.to_s
            next if code.empty?

            code.scan(item_code_pattern(type)).flatten.uniq.each { |slug| found << slug }
          end

          uniq ? found.uniq.sort : found.sort
        end

        # @param [ String ] type
        #
        # @return [ Regexp ]
        def item_attribute_pattern(type)
          @item_attribute_pattern ||= %r{\A#{item_url_pattern(type)}([^/]+)/}i
        end

        # @param [ String ] type
        #
        # @return [ Regexp ]
        def item_code_pattern(type)
          @item_code_pattern ||= %r{["'\( ]#{item_url_pattern(type)}([^\\\/\)"']+)}i
        end

        # @param [ String ] type
        #
        # @return [ Regexp ]
        def item_url_pattern(type)
          item_dir = type == 'plugins' ? target.plugins_dir : target.content_dir
          item_url = type == 'plugins' ? target.plugins_url : target.content_url

          url = /#{item_url.gsub(/\A(?:http|https)/i, 'https?').gsub('/', '\\\\\?\/')}/i
          item_dir = %r{(?:#{url}|\\?\/#{item_dir.gsub('/', '\\\\\?\/')}\\?/)}i

          type == 'plugins' ? item_dir : %r{#{item_dir}#{type}\\?\/}i
        end
      end
    end
  end
end
