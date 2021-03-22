# frozen_string_literal: true

require_relative 'wp_version/rss_generator'
require_relative 'wp_version/atom_generator'
require_relative 'wp_version/rdf_generator'
require_relative 'wp_version/readme'
require_relative 'wp_version/unique_fingerprinting'

module WPScan
  module Finders
    # Specific Finders container to filter the version detected
    # and remove the one with low confidence to avoid false
    # positive when there is not enough information to accurately
    # determine it.
    class WpVersionFinders < UniqueFinders
      def filter_findings
        best_finding = super

        best_finding && best_finding.confidence >= 40 ? best_finding : false
      end
    end

    module WpVersion
      # Wp Version Finder
      class Base
        include CMSScanner::Finders::UniqueFinder

        # @param [ WPScan::Target ] target
        def initialize(target)
          (%w[RSSGenerator AtomGenerator RDFGenerator] +
           DB::DynamicFinders::Wordpress.versions_finders_configs.keys +
           %w[Readme UniqueFingerprinting]
          ).each do |finder_name|
            finders << WpVersion.const_get(finder_name.to_sym).new(target)
          end
        end

        def finders
          @finders ||= Finders::WpVersionFinders.new
        end
      end
    end
  end
end
