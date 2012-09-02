#
# WPScan - WordPress Security Scanner
# Copyright (C) 2011  Ryan Dewhurst AKA ethicalhack3r
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
#

require "#{WPSCAN_LIB_DIR}/vulnerable"

class WpPlugin < Vulnerable
  @@location_url_pattern = %r{^(https?://.*/([^/]+)/)}i

  attr_reader :name

  def initialize(location_url, options = {})
    @location_uri = WpPlugin.location_uri_from_url(location_url)
    @name         = options[:name] || WpPlugin.extract_name_from_location_url(location_url)
    @vulns_xml    = options[:vulns_xml] || DATA_DIR + '/plugin_vulns.xml'
    @vulns_xpath  = "//plugin[@name='#{@name}']/vulnerability"
  end

  def location_url
    @location_uri.to_s
  end

  def ==(plugin)
    plugin.name == @name
  end

  def <=>(plugin)
    plugin.name <=> @name
  end

  # http://code.google.com/p/wpscan/issues/detail?id=97
  def version
    response = Browser.instance.get(@location_uri.merge("readme.txt").to_s)
    response.body[%r{stable tag: #{WpVersion.version_pattern}}i, 1]
  end

  def to_s
    version = version()
    "#{@name}#{' v' + version if version}"
  end

  # Discover any error_log files created by WordPress
  # These are created by the WordPress error_log() function
  # They are normally found in the /plugins/ directory,
  # however can also be found in their specific plugin dir.
  # http://www.exploit-db.com/ghdb/3714/
  def error_log?
    response_body = Browser.instance.get(error_log_url(), :headers => { "range" => "bytes=0-700"}).body
    response_body[%r{PHP Fatal error}i] ? true : false
  end

  def error_log_url
    @location_uri.merge("error_log").to_s
  end

  # Is directory listing enabled?
  # WordPress denies directory listing however,
  # forgets about the plugin directory.
  def directory_listing?
    Browser.instance.get(location_url()).body[%r{<title>Index of}] ? true : false
  end

  def self.create_location_url_from_name(name, target_uri)
    if target_uri.is_a?(String)
      target_uri = URI.parse(target_uri)
    end
    target_uri.merge(URI.escape("$wp-plugins$/#{name}/")).to_s
  end

  def self.create_url_from_raw(raw, target_uri)
    target_uri.merge(URI.escape("$wp-plugins$/#{raw}")).to_s
  end

  protected
  def self.extract_name_from_location_url(location_url)
    location_url[@@location_url_pattern, 2]
  end

  def self.location_uri_from_url(location_url)
    valid_location_url = location_url[%r{^(https?://.*/)[^.]+\.[^/]+$}, 1]

    unless valid_location_url
      valid_location_url = add_trailing_slash(location_url)
    end

    URI.parse(valid_location_url)
  end
end
