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
		(version1 == version2) || (Gem::Version.new(version1) < Gem::Version.new(version2))
	end
end
