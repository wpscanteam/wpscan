# frozen_string_literal: true

module WPScan
  module Model
    # WpItem (superclass of Plugin & Theme)
    class WpItem
      include Vulnerable
      include Finders::Finding
      include WPScan::Target::Platform::PHP
      include WPScan::Target::Server::Generic

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

        Array(db_data['vulnerabilities']).each do |json_vuln|
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
        return false if version && vuln&.introduced_in && version < vuln.introduced_in

        return true unless version && vuln&.fixed_in && !vuln.fixed_in.empty?

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

      # @return [ String, nil ]
      def last_updated
        resolve_last_updated unless defined?(@last_updated)
        @last_updated
      end

      # @return [ String, nil ] 'db', 'wordpress.org', or nil when last_updated is unknown
      def last_updated_source
        resolve_last_updated unless defined?(@last_updated_source)
        @last_updated_source
      end

      # WordPress.org takes precedence over local DB metadata since the WPScan
      # DB is not synced in real time and may be stale.
      def resolve_last_updated
        if (api_value = wordpress_org_data['last_updated'])
          @last_updated        = api_value
          @last_updated_source = 'WordPress.org'
        elsif (db_value = metadata['last_updated'])
          @last_updated        = db_value
          @last_updated_source = 'db'
        else
          @last_updated        = nil
          @last_updated_source = nil
        end
      end

      # @return [ String, nil ] Human-friendly relative time hint for last_updated
      #   (e.g. "3 months ago"). nil when last_updated cannot be parsed.
      def last_updated_relative
        @last_updated_relative ||= relative_time_for(last_updated)
      end

      # Parenthesized annotation appended to the CLI "Last Updated" line, e.g.
      # " (3 months ago, per wordpress.org)". Empty string when there is nothing
      # to annotate.
      #
      # @return [ String ]
      def last_updated_cli_suffix
        parts = []
        parts << last_updated_relative if last_updated_relative
        parts << 'per WordPress.org' if last_updated_source == 'WordPress.org'
        parts.empty? ? '' : " (#{parts.join(', ')})"
      end

      # ISO 8601 (UTC) representation of last_updated, used by the JSON output so
      # downstream consumers always see a consistent format regardless of whether
      # the value came from the local DB or the wordpress.org API.
      #
      # @return [ String, nil ]
      def last_updated_iso
        return @last_updated_iso if defined?(@last_updated_iso)

        @last_updated_iso = parse_last_updated&.iso8601
      end

      # Friendly representation of last_updated, used in CLI output, matching the
      # wordpress.org API style (e.g. "2026-04-14 12:01pm GMT"). Falls back to the
      # raw string when the value cannot be parsed.
      #
      # @return [ String, nil ]
      def last_updated_display
        return @last_updated_display if defined?(@last_updated_display)

        time = parse_last_updated
        @last_updated_display = time ? time.strftime('%Y-%m-%d %-l:%M%P GMT') : last_updated
      end

      # @return [ Time, nil ] last_updated parsed as UTC Time, or nil
      def parse_last_updated
        value = last_updated
        return nil if value.nil? || value.to_s.strip.empty?

        Time.parse(value.to_s).utc
      rescue ArgumentError, TypeError
        nil
      end

      # @param [ String, nil ] value A timestamp parseable by Time.parse
      # @return [ String, nil ]
      def relative_time_for(value)
        return nil if value.nil? || value.to_s.strip.empty?

        time  = Time.parse(value.to_s).utc
        delta = Time.now.utc - time
        return 'in the future' if delta.negative?

        seconds = delta.to_i
        case seconds
        when 0...60        then 'just now'
        when 60...3600     then pluralize_unit(seconds / 60, 'minute')
        when 3600...86_400 then pluralize_unit(seconds / 3600, 'hour')
        when 86_400...2_592_000 then pluralize_unit(seconds / 86_400, 'day')
        when 2_592_000...31_536_000 then pluralize_unit(seconds / 2_592_000, 'month')
        else pluralize_unit(seconds / 31_536_000, 'year')
        end
      rescue ArgumentError, TypeError
        nil
      end

      # @return [ String ]
      def pluralize_unit(count, unit)
        "#{count} #{unit}#{'s' if count != 1} ago"
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
        return false if detection_opts[:mode] == :passive

        super
      end

      # @param [ String ] path
      # @param [ Hash ] params The request params
      #
      # @return [ Boolean ]
      def error_log?(path = 'error_log', params = {})
        return false if detection_opts[:mode] == :passive

        super
      end

      # See WPScan::Target#head_and_get
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
        final_path = @path_from_blog.dup # @path_from_blog is set in the plugin/theme
        final_path << path unless path.nil?

        blog.head_and_get(final_path, codes, params)
      end
    end
  end
end
