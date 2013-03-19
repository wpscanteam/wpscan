# encoding: UTF-8

class WpItem
  module Infos

    # @return [ Boolean ]
    def has_readme?
      Browser.instance.get(readme_url).code == 200 ? true : false
    end

    # @return [ String ]
    def readme_url
      @uri.merge('readme.txt').to_s
    end

    # @return [ String ]
    def wordpress_url

    end

    def wordpress_org_item?

    end

    # @return [ Boolean ]
    def has_changelog?
      Browser.instance.get(changelog_url).code == 200 ? true : false
    end

    # @return [ String ]
    def changelog_url
      @uri.merge('changelog.txt').to_s
    end

    # @return [ Boolean ]
    def has_directory_listing?
      Browser.instance.get(@uri.to_s).body[%r{<title>Index of}] ? true : false
    end

    # Discover any error_log files created by WordPress
    # These are created by the WordPress error_log() function
    # They are normally found in the /plugins/ directory,
    # however can also be found in their specific plugin dir.
    # http://www.exploit-db.com/ghdb/3714/
    #
    # @return [ Boolean ]
    def has_error_log?
      response_body = Browser.instance.get(error_log_url, headers: {'range' => 'bytes=0-700'}).body
      response_body[%r{PHP Fatal error}i] ? true : false
    end

    # @return [ String ]
    def error_log_url
      @uri.merge('error_log').to_s
    end

  end
end
