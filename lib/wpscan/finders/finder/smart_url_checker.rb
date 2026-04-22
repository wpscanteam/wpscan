# frozen_string_literal: true

require 'wpscan/finders/finder/smart_url_checker/findings'

module WPScan
  module Finders
    class Finder
      # Smart URL Checker
      # Typically used when some URLs are potentially in the homepage. If they are found
      # in it, they will be checked in the #passive (like a browser/client would do when loading the page).
      # Otherwise they will be checked in the #aggressive
      module SmartURLChecker
        # @param [ Array<String> ] urls
        # @param [ Hash ] opts
        #
        # @return []
        def process_urls(_urls, _opts = {})
          raise NotImplementedError
        end

        # @param [ Hash ] opts
        #
        # @return [ Array<Finding> ]
        def passive(opts = {})
          process_urls(passive_urls(opts), opts)
        end

        # @param [ Hash ] opts
        #
        # @return [ Array<String> ]
        def passive_urls(_opts = {})
          target.in_scope_uris(target.homepage_res, passive_urls_xpath).map(&:to_s)
        end

        # @return [ String ]
        def passive_urls_xpath
          raise NotImplementedError
        end

        # @param [ Hash ] opts
        #
        # @return [ Array<Finding> ]
        def aggressive(opts = {})
          # To avoid scanning the same twice
          urls = aggressive_urls(opts)
          urls -= passive_urls(opts) if opts[:mode] == :mixed

          process_urls(urls, opts)
        end

        # @param [ Hash ] opts
        #
        # @return [ Array<String> ]
        def aggressive_urls(_opts = {})
          raise NotImplementedError
        end
      end
    end
  end
end
