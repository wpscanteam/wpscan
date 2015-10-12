# encoding: UTF-8

class WpTarget < WebSite
  module WpFullPathDisclosure
    # Check for Full Path Disclosure (FPD)
    #
    # @return [ Boolean ]
    def has_full_path_disclosure?
      Browser.get(full_path_disclosure_url).body[%r/Fatal error/i] ? true : false
    end

    def full_path_disclosure_data
      return nil unless has_full_path_disclosure?
      Browser.get(full_path_disclosure_url).body[/Fatal error:.+? in (.+?) on/i, 1]
    end

    # @return [ String ]
    def full_path_disclosure_url
      @uri.merge('wp-includes/rss-functions.php').to_s
    end
  end
end
