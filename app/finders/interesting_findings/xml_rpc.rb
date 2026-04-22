# frozen_string_literal: true

module WPScan
  module Finders
    module InterestingFindings
      # XML RPC finder
      class XMLRPC < Finder
        # @return [ Array<String> ] The potential urls to the XMl RPC file
        def potential_urls
          @potential_urls ||= []
        end

        # @return [ Array<XMLRPC> ]
        def passive(opts = {})
          [passive_headers(opts), passive_body(opts)].compact
        end

        # @return [ XMLRPC ]
        def passive_headers(_opts = {})
          url = target.homepage_res.headers['X-Pingback']

          return unless target.in_scope?(url)

          potential_urls << url

          NS::Model::XMLRPC.new(url, confidence: 30, found_by: 'Headers (Passive Detection)')
        end

        # @return [ XMLRPC ]
        def passive_body(_opts = {})
          target.homepage_res.html.css('link[rel="pingback"]').each do |tag|
            url = tag.attribute('href').to_s

            next unless target.in_scope?(url)

            potential_urls << url

            return NS::Model::XMLRPC.new(url, confidence: 30, found_by: 'Link Tag (Passive Detection)')
          end
          nil
        end

        # @return [ XMLRPC ]
        def aggressive(_opts = {})
          potential_urls << target.url('xmlrpc.php')

          potential_urls.uniq.each do |potential_url|
            next unless target.in_scope?(potential_url)

            res = NS::Browser.post(potential_url, body: Digest::MD5.hexdigest(rand(999_999).to_s[0..5]))

            next unless /<methodResponse>/i.match?(res&.body)

            return NS::Model::XMLRPC.new(potential_url, confidence: 100, found_by: DIRECT_ACCESS)
          end
          nil
        end
      end
    end
  end
end
