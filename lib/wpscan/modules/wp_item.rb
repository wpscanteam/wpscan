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

module WpItem
  attr_accessor :path, :url, :wp_content_dir
  @version = nil

  def get_url
    URI.parse("#{@url.to_s}#@wp_content_dir/#@path")
  end

  def get_url_without_filename
    uri = get_url
    URI.parse("#{uri.scheme}://#{uri.host}#{File.dirname(uri.path)}/")
  end

  def version
    unless @version
      response = Browser.instance.get(get_url.merge("readme.txt").to_s)
      @version = response.body[%r{stable tag: #{WpVersion.version_pattern}}i, 1]
    end
    @version
  end

  # Is directory listing enabled?
  def directory_listing?
    # Need to remove to file part from the url
    Browser.instance.get(location_uri_from_file_url(get_url.to_s)).body[%r{<title>Index of}] ? true : false
  end

  def extract_name_from_url(url)
    url.to_s[%r{^(https?://.*/([^/]+)/)}i, 2]
  end

  def to_s
    item_version = version
    "#@name#{' v' + item_version if item_version}"
  end

  def ==(item)
    item.name == @name
  end

  def <=>(item)
    item.name <=> @name
  end

  def location_uri_from_file_url(location_url)
    valid_location_url = location_url[%r{^(https?://.*/)[^.]+\.[^/]+$}, 1]
    unless valid_location_url
      valid_location_url = add_trailing_slash(location_url)
    end
    URI.parse(valid_location_url)
  end

end
