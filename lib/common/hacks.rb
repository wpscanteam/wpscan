# encoding: UTF-8

# Default option changed from DEFAULT_XML to NOBLANKS
module Nokogiri
  class << self
    def XML thing, url = nil, encoding = nil, options = XML::ParseOptions::NOBLANKS, &block
      Nokogiri::XML::Document.parse(thing, url, encoding, options, &block)
    end
  end
end

# Since ruby 1.9.2, URI::escape is obsolete
# See http://rosettacode.org/wiki/URL_encoding#Ruby and http://www.ruby-forum.com/topic/207489
if RUBY_VERSION >= '1.9.2'
  module URI
    def self.escape(str)
      URI.encode_www_form_component(str).gsub('+', '%20')
    end
  end
end

if RUBY_VERSION < '1.9'
  class Array
    # Fix for grep with symbols in ruby <= 1.8.7
    def _grep_(regexp)
      matches = []
      self.each do |value|
        value = value.to_s
        matches << value if value.match(regexp)
      end
      matches
    end

    alias_method :grep, :_grep_
  end
end

# Override for puts to enable logging
def puts(o = '')
  # remove color for logging
  if o.respond_to?('gsub')
    temp = o.gsub(/\e\[\d+m(.*)?\e\[0m/, '\1')
    File.open(LOG_FILE, 'a+') { |f| f.puts(temp) }
  end
  super(o)
end
