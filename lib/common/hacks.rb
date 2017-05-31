# encoding: UTF-8

# This is used in WpItem::Existable
module Typhoeus
  class Response

    # Compare the body hash to error_404_hash and homepage_hash
    # returns true if they are different, false otherwise
    #
    # @return [ Boolean ]
    def has_valid_hash?(error_404_hash, homepage_hash)
      body_hash = WebSite.page_hash(self)

      body_hash != error_404_hash && body_hash != homepage_hash
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
