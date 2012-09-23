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

module WpPlugins

  # Enumerate installed plugins.
  #
  # return array of WpPlugin
  def plugins_from_aggressive_detection(options)
    options[:file]          = options[:file] || "#{DATA_DIR}/plugins.txt"
    options[:vulns_file]    = options[:vulns_file] || "#{DATA_DIR}/plugin_vulns.xml"
    options[:vulns_xpath]   = "//plugin[@name='#{@name}']/vulnerability"
    options[:vulns_xpath_2] = "//plugin"
    options[:type]          = "plugins"
    result = WpDetector.aggressive_detection(options)
    plugins = []
    result.each do |r|
      plugins << WpPlugin.new(
          :base_url       => r.base_url,
          :path           => r.path,
          :wp_content_dir => r.wp_content_dir,
          :name           => r.name,
          :type           => "plugins",
          :wp_plugins_dir => r.wp_plugins_dir
      )
    end
    plugins.sort_by { |p| p.name }
  end

  # http://code.google.com/p/wpscan/issues/detail?id=42
  # plugins can be found in the source code :
  #   <script src='http://example.com/wp-content/plugins/s2member/...' />
  #   <link rel='stylesheet' href='http://example.com/wp-content/plugins/wp-minify/..' type='text/css' media='screen'/>
  #   ...
  # return array of WpPlugin
  def plugins_from_passive_detection(options)
    plugins = []
    temp = WpDetector.passive_detection(options[:base_url], "plugins", options[:wp_content_dir])

    temp.each do |item|
      plugins << WpPlugin.new(
          :base_url       => item.base_url,
          :name           => item.name,
          :path           => item.path,
          :wp_content_dir => options[:wp_content_dir],
          :type           => "plugins",
          :wp_plugins_dir => options[:wp_plugins_dir]
      )
    end
    plugins.sort_by { |p| p.name }
  end

end
