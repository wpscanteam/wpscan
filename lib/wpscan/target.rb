# frozen_string_literal: true

require 'wpscan/web_site'
require 'wpscan/target/platform'
require 'wpscan/target/server'
require 'wpscan/target/scope'
require 'wpscan/target/hashes'
require 'wpscan/target/platform/wordpress'

module WPScan
  # Target to Scan (WordPress).
  class Target < WebSite
    include Server::Generic
    include Platform::WordPress

    # @param [ String ] url
    # @param [ Hash ] opts
    # @option opts [ Array<PublicSuffix::Domain, String> ] :scope
    def initialize(url, opts = {})
      super

      scope << uri.host
      Array(opts[:scope]).each { |s| scope << s }
    end

    # @return [ Hash ]
    def head_or_get_request_params
      @head_or_get_request_params ||= if Browser.head(url).code == 405
                                        { method: :get, maxfilesize: 1 }
                                      else
                                        { method: :head }
                                      end
    end

    # @return [ Boolean ]
    def vulnerable?
      [@wp_version, @main_theme, @plugins, @themes, @timthumbs].each do |e|
        Array(e).each { |ae| return true if ae && ae.vulnerable? } # rubocop:disable Style/SafeNavigation
      end

      return true unless Array(@config_backups).empty?
      return true unless Array(@db_exports).empty?

      Array(@users).each { |u| return true if u.password }

      false
    end

    # @param [ Hash ] opts
    #
    # @return [ Findings ]
    def interesting_findings(opts = {})
      @interesting_findings ||= WPScan::Finders::InterestingFindings::Base.find(self, opts)
    end

    # @return [ XMLRPC, nil ]
    def xmlrpc
      @xmlrpc ||= interesting_findings&.grep(Model::XMLRPC)&.first
    end

    # @return [ Regexp ] The pattern related to the target url, also matches escaped /, such as
    #                    in JSON JS data: http:\/\/t.com\/
    def url_pattern
      @url_pattern ||= Regexp.new(Regexp.escape(url).gsub(/https?/i, 'https?').gsub('/', '\\\\\?/'), Regexp::IGNORECASE)
    end

    # @param [ String ] xpath
    # @param [ Regexp ] pattern
    # @param [ Typhoeus::Response, String ] page
    #
    # @return [ Array<Array<MatchData, Nokogiri::XML::Element>> ]
    # @yield  [ MatchData, Nokogiri::XML::Element ]
    def xpath_pattern_from_page(xpath, pattern, page = nil)
      page    = WPScan::Browser.get(url(page)) unless page.is_a?(Typhoeus::Response)
      matches = []

      page.html.xpath(xpath).each do |node|
        next unless node.text.strip =~ pattern

        yield Regexp.last_match, node if block_given?

        matches << [Regexp.last_match, node]
      end

      matches
    end

    # @param [ Regexp ] pattern
    # @param [ Typhoeus::Response, String ] page
    #
    # @return [ Array<Array<MatchData, Nokogiri::XML::Comment>> ]
    # @yield  [ MatchData, Nokogiri::XML::Comment ]
    def comments_from_page(pattern, page = nil)
      xpath_pattern_from_page('//comment()', pattern, page) do |match, node|
        yield match, node if block_given?
      end
    end

    # @param [ Regexp ] pattern
    # @param [ Typhoeus::Response, String ] page
    #
    # @return [ Array<Array<MatchData, Nokogiri::XML::Element>> ]
    # @yield  [ MatchData, Nokogiri::XML::Element ]
    def javascripts_from_page(pattern, page = nil)
      xpath_pattern_from_page('//script', pattern, page) do |match, node|
        yield match, node if block_given?
      end
    end

    # @param [ Typhoeus::Response, String ] page
    # @param [ String ] xpath
    #
    # @yield [ Addressable::URI, Nokogiri::XML::Element ] The url and its associated tag
    #
    # @return [ Array<Addressable::URI> ] The absolute URIs detected in the response's body from the HTML tags
    #
    # @note It is highly recommended to use the xpath parameter to focus on the uris needed, as this method can be quite
    #       time consuming when there are a lof of uris to check
    def uris_from_page(page = nil, xpath = '//@href|//@src|//@data-src')
      page  = WPScan::Browser.get(url(page)) unless page.is_a?(Typhoeus::Response)
      found = []

      page.html.xpath(xpath).each do |node|
        attr_value = node.text.to_s

        next unless attr_value && !attr_value.empty?

        node_uri = begin
          uri.join(attr_value.strip)
        rescue StandardError
          # Skip potential malformed URLs etc.
          next
        end

        next unless node_uri.host

        yield node_uri, node.parent if block_given? && !found.include?(node_uri)

        found << node_uri
      end

      found.uniq
    end

    # @param [ Hash ] opts
    #
    # @return [ WpVersion, false ] The WpVersion found or false if not detected
    def wp_version(opts = {})
      @wp_version = Finders::WpVersion::Base.find(self, opts) if @wp_version.nil?

      @wp_version
    end

    # @param [ Hash ] opts
    #
    # @return [ Theme ]
    def main_theme(opts = {})
      @main_theme = Finders::MainTheme::Base.find(self, opts) if @main_theme.nil?

      @main_theme
    end

    # @param [ Hash ] opts
    #
    # @return [ Array<Plugin> ]
    def plugins(opts = {})
      @plugins ||= Finders::Plugins::Base.find(self, opts)
    end

    # @param [ Hash ] opts
    #
    # @return [ Array<Theme> ]
    def themes(opts = {})
      @themes ||= Finders::Themes::Base.find(self, opts)
    end

    # @param [ Hash ] opts
    #
    # @return [ Array<Timthumb> ]
    def timthumbs(opts = {})
      @timthumbs ||= Finders::Timthumbs::Base.find(self, opts)
    end

    # @param [ Hash ] opts
    #
    # @return [ Array<ConfigBackup> ]
    def config_backups(opts = {})
      @config_backups ||= Finders::ConfigBackups::Base.find(self, opts)
    end

    # @param [ Hash ] opts
    #
    # @return [ Array<DBExport> ]
    def db_exports(opts = {})
      @db_exports ||= Finders::DbExports::Base.find(self, opts)
    end

    # @param [ Hash ] opts
    #
    # @return [ Array<BackupFolder> ]
    def backup_folders(opts = {})
      @backup_folders ||= Finders::BackupFolders::Base.find(self, opts)
    end

    # @param [ Hash ] opts
    #
    # @return [ Array<Media> ]
    def medias(opts = {})
      @medias ||= Finders::Medias::Base.find(self, opts)
    end

    # @param [ Hash ] opts
    #
    # @return [ Array<User> ]
    def users(opts = {})
      @users ||= Finders::Users::Base.find(self, opts)
    end
  end
end
