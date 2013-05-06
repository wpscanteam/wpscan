# encoding: UTF-8

class VersionCompare
	def self.is_newer_or_same?(version1, version2)
		(version1 == version2) || (Gem::Version.new(version1) < Gem::Version.new(version2))
	end
end