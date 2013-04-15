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
      %w{readme.txt README.txt}.each do |readme|
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
      Browser.get(@uri.to_s).body[%r{<title>Index of}] ? true : false
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
      response_body = Browser.get(error_log_url, headers: {'range' => 'bytes=0-700'}).body
      response_body[%r{PHP Fatal error}i] ? true : false
    end

    # @return [ String ] The url to the error_log file
    def error_log_url
      @uri.merge('error_log').to_s
    end

  end

end
