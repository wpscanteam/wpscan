#--
# WPScan - WordPress Security Scanner
# Copyright (C) 2012
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#++

class WpDetector

  def self.aggressive_detection(options, items = [])
    WpOptions.check_options(options)

    result = items
    if items == nil or items.length == 0
      result = passive_detection(options[:base_url], options[:type], options[:wp_content_dir])
    end

    enum_results = WpEnumerator.enumerate(options)
    enum_results.each do |enum_result|
      already_present = false
      result.each do |r|
        # Already found via passive detection
        if r.name == enum_result.name
          already_present = true
          break
        end
      end
      unless already_present
        result << enum_result
      end
    end
    result
  end

  # plugins and themes can be found in the source code :
  #   <script src='http://example.com/wp-content/plugins/s2member/...' />
  #   <link rel='stylesheet' href='http://example.com/wp-content/plugins/wp-minify/..' type='text/css' media='screen'/>
  #   ...
  def self.passive_detection(url, type, wp_content_dir)
    items         = []
    response      = Browser.instance.get(url)
    regex1        = %r{(?:[^=:]+)\s?(?:=|:)\s?(?:"|')[^"']+\\?/}
    regex2        = %r{\\?/}
    regex3        = %r{\\?/([^/\\"']+)\\?(?:/|"|')}
    # Custom wp-content dir is now used in this regex
    names = response.body.scan(/#{regex1}#{Regexp.escape(wp_content_dir)}#{regex2}#{Regexp.escape(type)}#{regex3}/i)

    names.flatten!
    names.uniq!

    names.each do |item|
      items << WpItem.new(
          :base_url       => url,
          :name           => item,
          :type           => type,
          :path           => "#{item}/",
          :wp_content_dir => wp_content_dir,
          :vulns_file     => ""
      )
    end
    items
  end

end
