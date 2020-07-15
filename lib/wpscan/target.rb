# frozen_string_literal: true

require 'wpscan/target/platform/wordpress'

module WPScan
  # Includes the WordPress Platform
  class Target < CMSScanner::Target
    include Platform::WordPress

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

    # @return [ XMLRPC, nil ]
    def xmlrpc
      @xmlrpc ||= interesting_findings&.select { |f| f.is_a?(Model::XMLRPC) }&.first
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
