# frozen_string_literal: true

module WPScan
  module Model
    # WordPress Plugin
    class Plugin < WpItem
      # See WpItem
      def initialize(slug, blog, opts = {})
        super(slug, blog, opts)

        # To be used by #head_and_get
        # If custom wp-content, it will be replaced by blog#url
        @path_from_blog = "wp-content/plugins/#{slug}/"

        @uri = Addressable::URI.parse(blog.url(path_from_blog))
      end

      # Retrieve the metadata from the vuln API if available (and a valid token is given),
      # or the local metadata db otherwise
      # @return [ Hash ]
      def metadata
        @metadata ||= db_data.empty? ? DB::Plugin.metadata_at(slug) : db_data
      end

      # @return [ Hash ]
      def db_data
        @db_data ||= DB::VulnApi.plugin_data(slug)
      end

      # @param [ Hash ] opts
      #
      # @return [ Model::Version, false ]
      def version(opts = {})
        @version = Finders::PluginVersion::Base.find(self, version_detection_opts.merge(opts)) if @version.nil?

        @version
      end

      # @return [ Array<String> ]
      def potential_readme_filenames
        @potential_readme_filenames ||= Array((DB::DynamicFinders::Plugin.df_data.dig(slug, 'Readme', 'path') || super))
      end
    end
  end
end
