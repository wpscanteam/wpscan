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

require "#{WPSCAN_LIB_DIR}/vulnerable"

class WpItem < Vulnerable
  attr_reader :base_url, :path, :wp_content_dir, :name, :vulns_file, :vulns_xpath, :wp_plugins_dir, :type
  @version = nil

  def initialize(options)
    @type           = options[:type]
    @wp_content_dir = options[:wp_content_dir] ? options[:wp_content_dir].sub(/^\//, "").sub(/\/$/, "") : "wp-content"
    @wp_plugins_dir = options[:wp_plugins_dir] || "#@wp_content_dir/plugins"
    @base_url       = options[:base_url]
    @path           = options[:path]
    @name           = options[:name] || extract_name_from_url
    @vulns_file     = options[:vulns_file]
    @vulns_xpath    = options[:vulns_xpath].sub(/\$name\$/, @name) unless options[:vulns_xpath] == nil

    raise("base_url not set")       unless @base_url
    raise("path not set")           unless @path
    raise("wp_content_dir not set") unless @wp_content_dir
    raise("name not set")           unless @name
    raise("vulns_file not set")     unless @vulns_file
    raise("type not set")           unless @type
  end

  def get_sub_folder
    case @type
      when "themes"
        folder = "themes"
      when "timthumbs"
        # not needed
        folder = nil
      else
        raise("unknown type #@type")
    end
    folder
  end

  # Get the full url for this item
  def get_full_url
    url = @base_url.to_s.end_with?("/") ? @base_url.to_s : "#@base_url/"
    # remove first and last /
    wp_content_dir = @wp_content_dir.sub(/^\//, "").sub(/\/$/, "")
    # remove first /
    path = @path.sub(/^\//, "")
    if type =="plugins"
      # plugins can be outside of wp-content. wp_content_dir included in wp_plugins_dir
      ret = URI.parse("#{url}#@wp_plugins_dir/#{path}")
    elsif type == "timthumbs"
      # timthumbs have folder in path variable
      ret = URI.parse("#{url}#{wp_content_dir}/#{path}")
    else
      ret = URI.parse("#{url}#{wp_content_dir}/#{get_sub_folder}/#{path}")
    end
    ret
  end

  # Gets the full url for this item without filenames
  def get_url_without_filename
    location_url = get_full_url.to_s
    valid_location_url = location_url[%r{^(https?://.*/)[^.]+\.[^/]+$}, 1]
    unless valid_location_url
      valid_location_url = add_trailing_slash(location_url)
    end
    URI.parse(valid_location_url)
  end

  # Returns version number from readme.txt if it exists
  def version
    unless @version
      response = Browser.instance.get(get_full_url.merge("readme.txt").to_s)
      @version = response.body[%r{stable tag: #{WpVersion.version_pattern}}i, 1]
    end
    @version
  end

  # Is directory listing enabled?
  def directory_listing?
    # Need to remove to file part from the url
    Browser.instance.get(get_url_without_filename).body[%r{<title>Index of}] ? true : false
  end

  # Extract item name from a url
  def extract_name_from_url
    get_full_url.to_s[%r{^(https?://.*/([^/]+)/)}i, 2]
  end

  # To string. Adds a version number if detected
  def to_s
    item_version = version
    "#@name#{' v' + item_version.strip if item_version}"
  end

  # Compare
  def ==(other)
    other.name == self.name
  end

  # Compare
  def ===(other)
    other.name == self.name
  end

  # Compare
  def <=>(other)
    other.name <=> self.name
  end

  # Url for readme.txt
  def readme_url
    get_url_without_filename.merge("readme.txt")
  end

  # Url for changelog.txt
  def changelog_url
    get_url_without_filename.merge("changelog.txt")
  end

  # readme.txt present?
  def has_readme?
    unless @readme
      status = Browser.instance.get(readme_url).code
      @readme = status == 200 ? true : false
    end
    @readme
  end

  # changelog.txt present?
  def has_changelog?
    unless @changelog
      status = Browser.instance.get(changelog_url).code
      @changelog = status == 200 ? true : false
    end
    @changelog
  end

end
