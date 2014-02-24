# encoding: UTF-8

class WpTimthumb < WpItem
  module Vulnerable
    def vulnerable?
      VersionCompare.is_newer_or_same?(version, '1.34')
    end
  end
end
