# frozen_string_literal: true

module WPScan
  module Model
    # WordPress Theme
    class Theme < WpItem
      attr_reader :style_url, :style_name, :style_uri, :author, :author_uri, :template, :description,
                  :license, :license_uri, :tags, :text_domain

      # See WpItem
      def initialize(slug, blog, opts = {})
        super(slug, blog, opts)

        # To be used by #head_and_get
        # If custom wp-content, it will be replaced by blog#url
        @path_from_blog = "wp-content/themes/#{slug}/"

        @uri       = Addressable::URI.parse(blog.url(path_from_blog))
        @style_url = opts[:style_url] || url('style.css')

        parse_style
      end

      # Retrieve the metadata from the vuln API if available (and a valid token is given),
      # or the local metadata db otherwise
      # @return [ JSON ]
      def metadata
        @metadata ||= db_data.empty? ? DB::Theme.metadata_at(slug) : db_data
      end

      # @return [ Hash ]
      def db_data
        @db_data ||= DB::VulnApi.theme_data(slug)
      end

      # @param [ Hash ] opts
      #
      # @return [ Model::Version, false ]
      def version(opts = {})
        @version = Finders::ThemeVersion::Base.find(self, version_detection_opts.merge(opts)) if @version.nil?

        @version
      end

      # @return [ Theme ]
      def parent_theme
        return unless template
        return unless style_body =~ /^@import\surl\(["']?([^"'\)]+)["']?\);\s*$/i

        opts = detection_opts.merge(
          style_url: url(Regexp.last_match[1]),
          found_by: 'Parent Themes (Passive Detection)',
          confidence: 100
        ).merge(version_detection: version_detection_opts)

        self.class.new(template, blog, opts)
      end

      # @param [ Integer ] depth
      #
      # @retun [ Array<Theme> ]
      def parent_themes(depth = 3)
        theme  = self
        found  = []

        (1..depth).each do |_|
          parent = theme.parent_theme

          break unless parent

          found << parent
          theme = parent
        end

        found
      end

      def style_body
        @style_body ||= Browser.get(style_url).body
      end

      def parse_style
        {
          style_name: 'Theme Name',
          style_uri: 'Theme URI',
          author: 'Author',
          author_uri: 'Author URI',
          template: 'Template',
          description: 'Description',
          license: 'License',
          license_uri: 'License URI',
          tags: 'Tags',
          text_domain: 'Text Domain'
        }.each do |attribute, tag|
          instance_variable_set(:"@#{attribute}", parse_style_tag(style_body, tag))
        end
      end

      # @param [ String ] bofy
      # @param [ String ] tag
      #
      # @return [ String ]
      def parse_style_tag(body, tag)
        value = body[/#{Regexp.escape(tag)}:[\t ]*([^\r\n\*]+)/i, 1]

        value && !value.strip.empty? ? value.strip : nil
      end

      def ==(other)
        super(other) && style_url == other.style_url
      end
    end
  end
end
