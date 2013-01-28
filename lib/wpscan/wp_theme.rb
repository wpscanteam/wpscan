# encoding: UTF-8
#--
# WPScan - WordPress Security Scanner
# Copyright (C) 2012-2013
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

require "#{WPSCAN_LIB_DIR}/vulnerable"

class WpTheme < WpItem

  attr_reader :style_url, :version

  def initialize(options = {})
    if options[:vulns_file].nil? or options[:vulns_file] == ''
      options[:vulns_file] = THEMES_VULNS_FILE
    end

    options[:vulns_xpath] = "//theme[@name='$name$']/vulnerability"
    options[:type]        = 'themes'
    @version              = options[:version]
    @style_url            = options[:style_url]

    super(options)
  end

  def version
    unless @version
      if @style_url
        @version = Browser.instance.get(@style_url).body[%r{Version:\s([^\s]+)}i, 1]
      end
    end
    @version
  end

  def self.find(target_uri)
    self.methods.grep(/find_from_/).each do |method_to_call|
      theme = self.send(method_to_call, target_uri)

      return theme if theme
    end
    nil
  end

  def ===(wp_theme)
    wp_theme.name === @name and wp_theme.version === @version
  end

  protected

  # Discover the wordpress theme name by parsing the css link rel
  def self.find_from_css_link(target_uri)
    response = Browser.instance.get(target_uri.to_s, { follow_location: true, max_redirects: 2 })

    # https + domain is optional because of relative links
    matches = %r{(?:https?://[^"']+)?/([^/]+)/themes/([^"']+)/style.css}i.match(response.body)
    if matches
      style_url = matches[0]
      wp_content_dir = matches[1]
      theme_name = matches[2]

      return new(
        name:            theme_name,
        style_url:       style_url,
        base_url:        target_uri,
        path:            theme_name,
        wp_content_dir:  wp_content_dir
      )
    end
  end

  # http://code.google.com/p/wpscan/issues/detail?id=141
  def self.find_from_wooframework(target_uri)
    body = Browser.instance.get(target_uri.to_s).body
    regexp = %r{<meta name="generator" content="([^\s"]+)\s?([^"]+)?" />\s+<meta name="generator" content="WooFramework\s?([^"]+)?" />}

    matches = regexp.match(body)
    if matches
      woo_theme_name = matches[1]
      woo_theme_version = matches[2]
      woo_framework_version = matches[3] # Not used at this time

      return new(
        name:            woo_theme_name,
        version:         woo_theme_version,
        base_url:        matches[0],
        path:            '',
        wp_content_dir:  ''
      )
    end
  end
end
