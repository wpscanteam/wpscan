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

module WpThemes

  def themes_from_aggressive_detection(options)
    options[:file]          = options[:file] || "#{DATA_DIR}/themes.txt"
    options[:vulns_file]    = (options[:vulns_file] != nil and options[:vulns_file] != "") ?
        options[:vulns_file] : DATA_DIR + "/wp_theme_vulns.xml"
    options[:vulns_xpath]   = "//theme[@name='#{@name}']/vulnerability"
    options[:vulns_xpath_2] = "//theme"
    options[:type]          = "themes"
    result = WpDetector.aggressive_detection(options)
    themes = []
    result.each do |r|
      themes << WpTheme.new(
          :base_url       => r.base_url,
          :path           => r.path,
          :wp_content_dir => r.wp_content_dir,
          :name           => r.name
      )
    end
    themes.sort_by { |t| t.name }
  end

  def themes_from_passive_detection(options)
    themes = []
    temp = WpDetector.passive_detection(options[:base_url], "themes", options[:wp_content_dir])

    temp.each do |item|
      themes << WpTheme.new(
          :base_url       => item.base_url,
          :name           => item.name,
          :path           => item.path,
          :wp_content_dir => options[:wp_content_dir]
      )
    end
    themes.sort_by { |t| t.name }
  end

end
