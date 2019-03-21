# frozen_string_literal: true

module WPScan
  module Finders
    module InterestingFindings
      # Must Use Plugins Directory checker
      class MuPlugins < CMSScanner::Finders::Finder
        # @return [ InterestingFinding ]
        def passive(_opts = {})
          pattern = %r{#{target.content_dir}/mu\-plugins/}i

          target.in_scope_urls(target.homepage_res) do |url|
            next unless Addressable::URI.parse(url).path =~ pattern

            url = target.url('wp-content/mu-plugins/')

            return Model::MuPlugins.new(
              url,
              confidence: 70,
              found_by: 'URLs In Homepage (Passive Detection)',
              to_s: "This site has 'Must Use Plugins': #{url}",
              references: { url: 'http://codex.wordpress.org/Must_Use_Plugins' }
            )
          end
          nil
        end

        # @return [ InterestingFinding ]
        def aggressive(_opts = {})
          url = target.url('wp-content/mu-plugins/')
          res = Browser.get_and_follow_location(url)

          return unless [200, 401, 403].include?(res.code)
          return if target.homepage_or_404?(res)

          # TODO: add the check for --exclude-content once implemented ?

          target.mu_plugins = true

          Model::MuPlugins.new(
            url,
            confidence: 80,
            found_by: DIRECT_ACCESS,
            to_s: "This site has 'Must Use Plugins': #{url}",
            references: { url: 'http://codex.wordpress.org/Must_Use_Plugins' }
          )
        end
      end
    end
  end
end
