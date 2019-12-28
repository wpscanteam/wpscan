# frozen_string_literal: true

module WPScan
  module Model
    # WpItem (superclass of Plugin & Theme)
    class WpItem
      include Vulnerable
      include Finders::Finding
      include CMSScanner::Target::Platform::PHP
      include CMSScanner::Target::Server::Generic

      # Most common readme filenames, based on checking all public plugins and themes.
      READMES = %w[readme.txt README.txt README.md readme.md Readme.txt].freeze

      attr_reader :uri, :slug, :detection_opts, :version_detection_opts, :blog, :path_from_blog, :db_data

      delegate :homepage_res, :error_404_res, :xpath_pattern_from_page, :in_scope_uris, :head_or_get_params, to: :blog

      # @param [ String ] slug The plugin/theme slug
      # @param [ Target ] blog The targeted blog
      # @param [ Hash ] opts
      # @option opts [ Symbol ] :mode The detection mode to use
      # @option opts [ Hash ]   :version_detection The options to use when looking for the version
      # @option opts [ String ] :url The URL of the item
      def initialize(slug, blog, opts = {})
        @slug  = Addressable::URI.unencode(slug)
        @blog  = blog
        @uri   = Addressable::URI.parse(opts[:url]) if opts[:url]

        @detection_opts         = { mode: opts[:mode] }
        @version_detection_opts = opts[:version_detection] || {}

        parse_finding_options(opts)
      end

      # @return [ Array<Vulnerabily> ]
      def vulnerabilities
        return @vulnerabilities if @vulnerabilities

        @vulnerabilities = []

        [*db_data['vulnerabilities']].each do |json_vuln|
          vulnerability = Vulnerability.load_from_json(json_vuln)
          @vulnerabilities << vulnerability if vulnerable_to?(vulnerability)
        end

        @vulnerabilities
      end

      # Checks if the wp_item is vulnerable to a specific vulnerability
      #
      # @param [ Vulnerability ] vuln Vulnerability to check the item against
      #
      # @return [ Boolean ]
      def vulnerable_to?(vuln)
        return true unless version && vuln && vuln.fixed_in && !vuln.fixed_in.empty?

        version < vuln.fixed_in
      end

      # @return [ String ]
      def latest_version
        @latest_version ||= metadata['latest_version'] ? Model::Version.new(metadata['latest_version']) : nil
      end

      # Not used anywhere ATM
      # @return [ Boolean ]
      def popular?
        @popular ||= metadata['popular'] ? true : false
      end

      # @return [ String ]
      def last_updated
        @last_updated ||= metadata['last_updated']
      end

      # @return [ Boolean ]
      def outdated?
        @outdated ||= if version && latest_version
                        version < latest_version
                      else
                        false
                      end
      end

      # @param [ String ] path Optional path to merge with the uri
      #
      # @return [ String ]
      def url(path = nil)
        return unless @uri
        return @uri.to_s unless path

        @uri.join(Addressable::URI.encode(path)).to_s
      end

      # @return [ Boolean ]
      def ==(other)
        self.class == other.class && slug == other.slug
      end

      def to_s
        slug
      end

      # @return [ Symbol ] The Class symbol associated to the item
      def classify
        @classify ||= classify_slug(slug)
      end

      # @return [ String, False ] The readme url if found, false otherwise
      def readme_url
        return if detection_opts[:mode] == :passive

        return @readme_url unless @readme_url.nil?

        potential_readme_filenames.each do |path|
          t_url = url(path)

          return @readme_url = t_url if Browser.forge_request(t_url, blog.head_or_get_params).run.code == 200
        end

        @readme_url = false
      end

      def potential_readme_filenames
        @potential_readme_filenames ||= READMES
      end

      # @param [ String ] path
      # @param [ Hash ] params The request params
      #
      # @return [ Boolean ]
      def directory_listing?(path = nil, params = {})
        return if detection_opts[:mode] == :passive

        super(path, params)
      end

      # @param [ String ] path
      # @param [ Hash ] params The request params
      #
      # @return [ Boolean ]
      def error_log?(path = 'error_log', params = {})
        return if detection_opts[:mode] == :passive

        super(path, params)
      end

      # See CMSScanner::Target#head_and_get
      #
      # This is used by the error_log? above in the super()
      # to have the correct path (ie readme.txt checked from the plugin/theme location
      # and not from the blog root). Could also be used in finders
      #
      # @param [ String ] path
      # @param [ Array<String> ] codes
      # @param [ Hash ] params The requests params
      # @option params [ Hash ] :head Request params for the HEAD
      # @option params [ hash ] :get Request params for the GET
      #
      # @return [ Typhoeus::Response ]
      def head_and_get(path, codes = [200], params = {})
        final_path = +@path_from_blog
        final_path << path unless path.nil?

        blog.head_and_get(final_path, codes, params)
      end
    end
  end
end
