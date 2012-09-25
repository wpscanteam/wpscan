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

# Options Hash
#
# ==== Options
#
# * +url+ - The base URL of the WordPress site
# * +only_vulnerable_ones+ - Only detect vulnerable items
# * +file+ - Filename with items to detect
# * +vulns_file+ - XML file with vulnerabilities
# * +vulns_xpath+ - XPath for vulnerability XML file
# * +vulns_xpath_2+ - XPath for vulnerability XML file
# * +wp_content_dir+ - Name of the wp-content directory
# * +show_progress_bar+ - Show a progress bar during enumeration
# * +error_404_hash+ - MD5 hash of a 404 page
# * +type+ - Type: plugins, themes
class WpOptions
  def self.check_options(options)
    raise("base_url must be set")             unless options[:base_url] != nil and options[:base_url].to_s.length > 0
    raise("only_vulnerable_ones must be set") unless options[:only_vulnerable_ones] != nil
    raise("file must be set")                 unless options[:file] != nil and options[:file].length > 0
    raise("vulns_file must be set")           unless options[:vulns_file] != nil and options[:vulns_file].length > 0
    raise("vulns_xpath must be set")          unless options[:vulns_xpath] != nil and options[:vulns_xpath].length > 0
    raise("vulns_xpath_2 must be set")        unless options[:vulns_xpath_2] != nil and options[:vulns_xpath_2].length > 0
    raise("wp_content_dir must be set")       unless options[:wp_content_dir] != nil and options[:wp_content_dir].length > 0
    raise("show_progress_bar must be set")    unless options[:show_progress_bar] != nil
    raise("error_404_hash must be set")       unless options[:error_404_hash] != nil and options[:error_404_hash].length > 0
    raise("type must be set")                 unless options[:type] != nil and options[:type].length > 0

    unless options[:type] =~ /plugins/i or options[:type] =~ /themes/i or options[:type] =~ /timthumbs/i
      raise("Unknown type #{options[:type]}")
    end
  end

end
