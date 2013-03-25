# encoding: UTF-8

class WpItem

  # @uri is used instead of #uri to avoid the presence of the :path into it
  module Infos

    # @return [ Boolean ]
    def has_readme?
      Browser.instance.get(readme_url).code == 200 ? true : false
    end

    # @return [ String ] The url to the readme file
    def readme_url
      @uri.merge('readme.txt').to_s
    end

    # @return [ Boolean ]
    def has_changelog?
      Browser.instance.get(changelog_url).code == 200 ? true : false
    end

    # @return [ String ] The url to the changelog file
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
    # Only the first 700 bytes are checked to avoid the download
    # of the whole file which can be very huge (like 2 Go)
    #
    # @return [ Boolean ]
    def has_error_log?
      response_body = Browser.instance.get(error_log_url, headers: {'range' => 'bytes=0-700'}).body
      response_body[%r{PHP Fatal error}i] ? true : false
    end

    # @return [ String ] The url to the error_log file
    def error_log_url
      @uri.merge('error_log').to_s
    end

  end

end
