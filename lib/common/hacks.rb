# encoding: UTF-8

# Since ruby 1.9.2, URI::escape is obsolete
# See http://rosettacode.org/wiki/URL_encoding#Ruby and http://www.ruby-forum.com/topic/207489
if RUBY_VERSION >= '1.9.2'
  module URI
    extend self

    def escape(str)
      URI::Parser.new.escape(str)
    end
    alias :encode :escape

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

# This is used in WpItem::Existable
module Typhoeus
  class Response

    # Compare the body hash to error_404_hash and homepage_hash
    # returns true if they are different, false otherwise
    #
    # @return [ Boolean ]
    def has_valid_hash?(error_404_hash, homepage_hash)
      body_hash = Digest::MD5.hexdigest(self.body)

      body_hash != error_404_hash && body_hash != homepage_hash
    end

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
