# frozen_string_literal: true

module WPScan
  module Model
    # WpItem (superclass of Plugin & Theme)
    class WpItem
      include Vulnerable
      include Finders::Finding
      include CMSScanner::Target::Platform::PHP
      include CMSScanner::Target::Server::Generic

      READMES    = %w[readme.txt README.txt README.md readme.md Readme.txt].freeze
      CHANGELOGS = %w[changelog.txt CHANGELOG.md changelog.md].freeze

      attr_reader :uri, :slug, :detection_opts, :version_detection_opts, :blog, :db_data

      delegate :homepage_res, :xpath_pattern_from_page, :in_scope_urls, :head_and_get, to: :blog

      # @param [ String ] slug The plugin/theme slug
      # @param [ Target ] blog The targeted blog
      # @param [ Hash ] opts
      # @option opts [ Symbol ] :mode The detection mode to use
      # @option opts [ Hash ]   :version_detection The options to use when looking for the version
      # @option opts [ String ] :url The URL of the item
      def initialize(slug, blog, opts = {})
        @slug  = URI.decode(slug)
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
        @latest_version ||= db_data['latest_version'] ? Model::Version.new(db_data['latest_version']) : nil
      end

      # Not used anywhere ATM
      # @return [ Boolean ]
      def popular?
        @popular ||= db_data['popular']
      end

      # @return [ String ]
      def last_updated
        @last_updated ||= db_data['last_updated']
      end

      # @return [ Boolean ]
      def outdated?
        @outdated ||= if version && latest_version
                        version < latest_version
                      else
                        false
                      end
      end

      # URI.encode is preferered over Addressable::URI.encode as it will encode
      # leading # character:
      # URI.encode('#t#') => %23t%23
      # Addressable::URI.encode('#t#') => #t%23
      #
      # @param [ String ] path Optional path to merge with the uri
      #
      # @return [ String ]
      def url(path = nil)
        return unless @uri
        return @uri.to_s unless path

        @uri.join(URI.encode(path)).to_s
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

        READMES.each do |path|
          if Browser.instance.forge_request(url(path), blog.head_or_get_params).run.code == 200
            return @readme_url = url(path)
          end
        end

        @readme_url = false
      end

      # @return [ String, false ] The changelog url if found, false otherwise
      def changelog_url
        return if detection_opts[:mode] == :passive

        return @changelog_url unless @changelog_url.nil?

        CHANGELOGS.each do |path|
          if Browser.instance.forge_request(url(path), blog.head_or_get_params).run.code == 200
            return @changelog_url = url(path)
          end
        end

        @changelog_url = false
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
    end
  end
end
