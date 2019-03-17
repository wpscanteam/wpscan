module WPScan
  module Finders
    module WpVersion
      # Unique Fingerprinting Version Finder
      class UniqueFingerprinting < CMSScanner::Finders::Finder
        include CMSScanner::Finders::Finder::Fingerprinter

        # @return [ WpVersion ]
        def aggressive(opts = {})
          fingerprint(DB::Fingerprints.wp_unique_fingerprints, opts) do |version_number, url, md5sum|
            hydra.abort
            progress_bar.finish

            break WPScan::WpVersion.new(
              version_number,
              found_by: 'Unique Fingerprinting (Aggressive Detection)',
              confidence: 100,
              interesting_entries: ["#{url} md5sum is #{md5sum}"]
            )
          end
        end

        def create_progress_bar(opts = {})
          super(opts.merge(title: 'Fingerprinting the version -'))
        end
      end
    end
  end
end
