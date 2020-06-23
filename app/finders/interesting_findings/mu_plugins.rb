# frozen_string_literal: true

module WPScan
  module Finders
    module InterestingFindings
      # Must Use Plugins Directory checker
      class MuPlugins < CMSScanner::Finders::Finder
        # @return [ InterestingFinding ]
        def passive(_opts = {})
          pattern = %r{#{target.content_dir}/mu-plugins/}i

          target.in_scope_uris(target.homepage_res, '(//@href|//@src)[contains(., "mu-plugins")]') do |uri|
            next unless uri.path&.match?(pattern)

            url = target.url('wp-content/mu-plugins/')

            target.mu_plugins = true

            return Model::MuPlugins.new(url, confidence: 70, found_by: 'URLs In Homepage (Passive Detection)')
          end
          nil
        end

        # @return [ InterestingFinding ]
        def aggressive(_opts = {})
          url = target.url('wp-content/mu-plugins/')
          res = Browser.get_and_follow_location(url)

          return unless [200, 401, 403].include?(res.code)
          return if target.homepage_or_404?(res)

          target.mu_plugins = true

          Model::MuPlugins.new(url, confidence: 80, found_by: DIRECT_ACCESS)
        end
      end
    end
  end
end
