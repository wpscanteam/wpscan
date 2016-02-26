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
    File.open(LOG_FILE, 'a+') { |f| f.puts(temp) }
  end

  super(o)
end

module Terminal
  class Table
    def render
      separator = Separator.new(self)
      buffer = [separator]
      unless @title.nil?
        buffer << Row.new(self, [title_cell_options])
        buffer << separator
      end
      unless @headings.cells.empty?
        buffer << @headings
        buffer << separator
      end
      buffer += @rows
      buffer << separator
      buffer.map { |r| style.margin_left + r.render }.join("\n")
    end
    alias :to_s :render

    class Style
      @@defaults = {
        :border_x => '-', :border_y => '|', :border_i => '+',
        :padding_left => 1, :padding_right => 1,
        :margin_left => '',
        :width => nil, :alignment => nil
      }

      attr_accessor :margin_left
      attr_accessor :border_x
      attr_accessor :border_y
      attr_accessor :border_i

      attr_accessor :padding_left
      attr_accessor :padding_right

      attr_accessor :width
      attr_accessor :alignment
    end
  end
end

class Numeric
  def bytes_to_human
    units = %w{B KB MB GB TB}
    e = (Math.log(abs)/Math.log(1024)).floor
    s = '%.3f' % (abs.to_f / 1024**e)
    s.sub(/\.?0*$/, ' ' + units[e])
  end
end

# time calculations
class Fixnum
  SECONDS_IN_DAY = 24 * 60 * 60

  def days
    self * SECONDS_IN_DAY
  end

  def ago
    Time.now - self
  end
end
