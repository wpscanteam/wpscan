# frozen_string_literal: true

module WPScan
  module Finders
    module Plugins
      # Known Locations Plugins Finder
      class KnownLocations < WPScan::Finders::Finder
        include WPScan::Finders::Finder::Enumerator

        # @return [ Array<Integer> ]
        def valid_response_codes
          @valid_response_codes ||= [200, 401, 403, 500].freeze
        end

        # @param [ Hash ] opts
        # @option opts [ String ] :list
        # @option opts [ Findings ] :found Shared findings collection passed by
        #   BaseFinders#run_finder. We append directly into it as each plugin
        #   is detected so that Findings#on_append fires during the hydra run,
        #   enabling streaming output. Falls back to a local array when called
        #   outside the framework (e.g. directly from specs).
        #
        # @return [ Array<Plugin> ] Items appended this call (empty when
        #   already streamed into opts[:found] to avoid double-appending).
        def aggressive(opts = {})
          shared = opts[:found]
          local  = shared ? nil : []
          count  = 0

          enumerate(target_urls(opts), opts.merge(check_full_response: true)) do |res, slug|
            finding_opts = opts.merge(found_by: found_by,
                                      confidence: 80,
                                      interesting_entries: ["#{res.effective_url}, status: #{res.code}"])

            plugin = Model::Plugin.new(slug, target, finding_opts)
            (shared || local) << plugin
            count += 1

            raise Error::PluginsThresholdReached if opts[:threshold].positive? && count >= opts[:threshold]
          end

          local || []
        end

        # @param [ Hash ] opts
        # @option opts [ String ] :list
        #
        # @return [ Hash ]
        def target_urls(opts = {})
          slugs       = opts[:list] || DB::Plugins.vulnerable_slugs
          urls        = {}

          slugs.each do |slug|
            urls[target.plugin_url(slug)] = slug
          end

          urls
        end

        def create_progress_bar(opts = {})
          super(opts.merge(title: ' Checking Known Locations -'))
        end
      end
    end
  end
end
