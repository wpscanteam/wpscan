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
    options[:file]        = "#{DATA_DIR}/plugins.txt"
    options[:vulns_file]  = "#{DATA_DIR}/plugin_vulns.xml"
    options[:vulns_xpath] = "//plugin[@name='#{@name}']/vulnerability"
    options[:type]        = "plugins"
    result = WpDetector.aggressive_detection(options)
    result
  end

  private

  # http://code.google.com/p/wpscan/issues/detail?id=42
  # plugins can be found in the source code :
  #   <script src='http://example.com/wp-content/plugins/s2member/...' />
  #   <link rel='stylesheet' href='http://example.com/wp-content/plugins/wp-minify/..' type='text/css' media='screen'/>
  #   ...
  # return array of WpPlugin
  def plugins_from_passive_detection(wp_content_dir)
    plugins = []
    temp = WpDetector.passive_detection(url(), "plugins", wp_content_dir)

    temp.each do |item|
      plugins << WpPlugin.new(
          :base_url       => item[:base_url],
          :name           => item[:name],
          :path           => item[:path],
          :wp_content_dir => wp_content_dir
      )
    end
    plugins
  end

end
