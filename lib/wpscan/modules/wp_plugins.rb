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

module WpPlugins

  # Enumerate installed plugins.
  # Available options : see #targets_url
  #
  # return array of WpPlugin
  def plugins_from_aggressive_detection(options = {})
    browser              = Browser.instance
    hydra                = browser.hydra
    found_plugins        = options[:only_vulnerable_ones] ? [] : plugins_from_passive_detection()
    request_count        = 0
    queue_count          = 0
    local_404_hash       = error_404_hash()
    valid_response_codes = WpPlugins.valid_response_codes()
    targets_url          = plugins_targets_url(options)

    targets_url.each do |target_url|
      request       = browser.forge_request(target_url, :cache_timeout => 0, :follow_location => true)
      request_count += 1

      request.on_complete do |response|
        print "\rChecking for " + targets_url.size.to_s + " total plugins... #{(request_count * 100) / targets_url.size}% complete." # progress indicator

        if valid_response_codes.include?(response.code)
          if Digest::MD5.hexdigest(response.body) != local_404_hash
            found_plugins << WpPlugin.new(target_url)
          end
        end
      end

      hydra.queue(request)
      queue_count += 1

      if queue_count == browser.max_threads
        hydra.run
        queue_count = 0
      end
    end

    hydra.run

    found_plugins
  end

  def self.valid_response_codes
    [200, 403, 301, 302]
  end

  # Available options :
  #  :only_vulnerable_ones - default false
  #  :plugins_file - default DATA_DIR/plugins.txt
  #  :plugin_vulns_file - default DATA_DIR/plugin_vulns.xml
  #
  # @return Array of String
  def plugins_targets_url(options = {})
    only_vulnerable   = options[:only_vulnerable_ones] || false
    plugins_file      = options[:plugins_file] || "#{DATA_DIR}/plugins.txt"
    plugin_vulns_file = options[:plugin_vulns_file] || "#{DATA_DIR}/plugin_vulns.xml"
    targets_url       = []

    if only_vulnerable == false
      # Open and parse the 'most popular' plugin list...
      File.open(plugins_file, 'r') do |file|
        file.readlines.collect do |line|
          targets_url << WpPlugin.create_url_from_raw(line.chomp, @uri)
        end
      end
    end

    xml = Nokogiri::XML(File.open(plugin_vulns_file)) do |config|
      config.noblanks
    end

    # We check if the plugin name from the plugin_vulns_file is already in targets, otherwise we add it
    xml.xpath("//plugin").each do |node|
      plugin_name = node.attribute('name').text

      if targets_url.grep(%r{/#{plugin_name}/}).empty?
        targets_url << WpPlugin.create_location_url_from_name(plugin_name, url())
      end
    end

    targets_url.flatten!
    targets_url.uniq!
    # randomize the plugins array to *maybe* help in some crappy IDS/IPS/WAF detection
    targets_url.sort_by { rand }
  end

  # http://code.google.com/p/wpscan/issues/detail?id=42
  # plugins can be found in the source code :
  #   <script src='http://example.com/wp-content/plugins/s2member/...' />
  #   <link rel='stylesheet' href='http://example.com/wp-content/plugins/wp-minify/..' type='text/css' media='screen'/>
  #   ...
  # return array of WpPlugin
  def plugins_from_passive_detection
    plugins       = []
    response      = Browser.instance.get(url())
    plugins_names = response.body.scan(%r{(?:[^=:]+)\s?(?:=|:)\s?(?:"|')[^"']+\\?/wp-content\\?/plugins\\?/([^/\\"']+)\\?(?:/|"|')}i)

    plugins_names.flatten!
    plugins_names.uniq!

    plugins_names.each do |plugin_name|
      plugins << WpPlugin.new(
        WpPlugin.create_location_url_from_name(plugin_name, url()),
        :name => plugin_name
      )
    end
    plugins
  end

end
