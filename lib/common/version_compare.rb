# encoding: UTF-8

class VersionCompare

  # Compares two version strings. Returns true if version1 is equal to version2
  # or when version1 is older than version2
  #
  # @param [ String ] version1
  # @param [ String ] version2
  #
  # @return [ Boolean ]
  def self.is_newer_or_same?(version1, version2)
    return true if (version1 == version2)
    # Both versions must be set
    return false unless (version1 and version2)
    return false if (version1.empty? or version2.empty?)
    begin
      return true if (Gem::Version.new(version1) < Gem::Version.new(version2))
    rescue ArgumentError => e
      # Example: ArgumentError: Malformed version number string a
      return false if e.message =~ /Malformed version number string/
      raise
    end
    return false
  end
end
