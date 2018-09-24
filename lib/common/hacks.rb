# encoding: UTF-8

# This is used in WpItem::Existable
module Typhoeus
  class Response

    # Compare the body hash to error_404_hash_set and homepage_hash
    # returns true if it does not match known hashes, false otherwise
    #
    # @return [ Boolean ]
    def has_valid_hash?(error_404_hash_set, homepage_hash)
      body_hash = WebSite.page_hash(self)

      return false if error_404_hash_set && error_404_hash_set.include?(body_hash)
      return false if body_hash == homepage_hash
      return true
    end

  end
end

# Override for puts to enable logging
def puts(o = '')
  if $log && o.respond_to?(:gsub)
    temp = o.gsub(/\e\[\d+m/, '') # remove color for logging
    File.open($log, 'a+') { |f| f.puts(temp) }
  end

  super(o)
end

class Numeric
  def bytes_to_human
    units = %w{B KB MB GB TB}
    e = (Math.log(abs)/Math.log(1024)).floor
    s = '%.3f' % (abs.to_f / 1024**e)
    s.sub(/\.?0*$/, ' ' + units[e])
  end
end
