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
# * +wp_content_dir+ - Name of the wp-content directory
# * +show_progress_bar+ - Show a progress bar during enumeration
# * +error_404_hash+ - MD5 hash of a 404 page
# * +type+ - Type: plugins, themes
class WpOptions
  def self.get_empty_options
    options = {
        :url                  => "",
        :only_vulnerable_ones => true,
        :file                 => "",
        :vulns_file           => "",
        :vulns_xpath          => "",
        :wp_content_dir       => "",
        :show_progress_bar    => true,
        :error_404_hash       => "",
        :type                 => ""
    }
    options
  end

  def self.check_options(options)
    raise("url must be set")                  unless options[:url]
    raise("only_vulnerable_ones must be set") unless options[:only_vulnerable_ones]
    raise("file must be set")                 unless options[:file]
    raise("vulns_file must be set")           unless options[:vulns_file]
    raise("vulns_xpath must be set")          unless options[:vulns_xpath]
    raise("wp_content_dir must be set")       unless options[:wp_content_dir]
    raise("show_progress_bar must be set")    unless options[:show_progress_bar]
    raise("error_404_hash must be set")       unless options[:error_404_hash]
    raise("type must be set")                 unless options[:type]

    unless options[:type] =~ /plugins/i or options[:type] =~ /themes/i
      raise("Unknown type #{options[:type]}")
    end
  end

end