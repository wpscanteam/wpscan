# encoding: UTF-8

class WpItem

  # @uri is used instead of #uri to avoid the presence of the :path into it
  module Infos

    # @return [ Boolean ]
    def has_readme?
      !readme_url.nil?
    end

    # @return [ String,nil ] The url to the readme file, nil if not found
    def readme_url
      # See https://github.com/wpscanteam/wpscan/pull/737#issuecomment-66375445
      # for any question about the order
      %w{readme.txt README.txt Readme.txt ReadMe.txt README.TXT readme.TXT}.each do |readme|
        url = @uri.merge(readme).to_s
        return url if url_is_200?(url)
      end
      nil
    end

    # @return [ Boolean ]
    def has_changelog?
      url_is_200?(changelog_url)
    end

    # Checks if the url status code is 200
    #
    # @param [ String ] url
    #
    # @return [ Boolean ] True if the url status is 200
    def url_is_200?(url)
      Browser.get(url).code == 200
    end

    # @return [ String ] The url to the changelog file
    def changelog_url
      @uri.merge('changelog.txt').to_s
    end

    # @return [ Boolean ]
    def has_directory_listing?
      directory_listing_enabled?(@uri)
    end

    # Discover any error_log files created by WordPress
    # These are created by the WordPress error_log() function
    # They are normally found in the /plugins/ directory,
    # however can also be found in their specific plugin dir.
    # http://www.exploit-db.com/ghdb/3714/
    #
    # @return [ Boolean ]
    def has_error_log?
      WebSite.has_log?(error_log_url, %r{PHP Fatal error}i)
    end

    # @return [ String ] The url to the error_log file
    def error_log_url
      @uri.merge('error_log').to_s
    end

  end

end
