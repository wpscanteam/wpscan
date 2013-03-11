# encoding: UTF-8

# Default option changed from DEFAULT_XML to NOBLANKS
module Nokogiri
  class << self
    def XML thing, url = nil, encoding = nil, options = XML::ParseOptions::NOBLANKS, &block
      Nokogiri::XML::Document.parse(thing, url, encoding, options, &block)
    end
  end
end
