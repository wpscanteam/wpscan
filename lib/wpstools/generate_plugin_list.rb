#!/usr/bin/env ruby

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
# ryandewhurst at gmail
#

# This tool generates a plugin list to use for plugin enumeration

class Generate_Plugin_List

  attr_accessor :pages, :verbose

  def initialize(pages, verbose)
    @pages = pages.to_i
    @verbose = verbose
    @browser = Browser.instance
    @hydra = @browser.hydra
  end

  # Send a HTTP request to the WordPress most popular plugins webpage
  # parse the response for the plugin names.

  def parse_popular_plugins

    found_plugins = []
    page_count = 1
    queue_count = 0

    (1...@pages).each do |page|

      request = @browser.forge_request('http://wordpress.org/extend/plugins/browse/popular/page/'+page.to_s+'/')

      queue_count += 1

      request.on_complete do |response|
        puts "[+] Parsing page " + page_count.to_s if @verbose
        page_count += 1
        response.body.scan(%r{<h3><a href="http://wordpress.org/extend/plugins/(.*)/">.+</a></h3>}i).each do |plugin|
          found_plugins << plugin[0]
        end
      end

      @hydra.queue(request)

      if queue_count == @browser.max_threads
         @hydra.run
         queue_count = 0
       end

    end

    @hydra.run

    found_plugins.uniq
  end
    
  def parse_full_plugins
    found_plugins = []
    queue_count = 0
    index = @browser.get('http://plugins.svn.wordpress.org/').body
    index.scan(%r{<li><a href=".*">(.*)/</a></li>}i).each do |plugin|
      found_plugins << plugin[0]
    end
    found_plugins.uniq
  end

  # Use the WordPress plugin SVN repo to find a
  # valid plugin file. This will cut down on
  # false positives. See issue 39.

  def parse_plugin_files(plugins)

    plugins_with_paths = ""
    queue_count = 0

    plugins.each do |plugin|

  	  request = @browser.forge_request('http://plugins.svn.wordpress.org/' + plugin  + '/trunk/')

      request.on_complete do |response|

        puts "[+] Parsing plugin " + plugin  + " [" + response.code.to_s  + "]" if @verbose
        file = response.body[%r{<li><a href="(\d*?[a-zA-Z].*\..*)">.+</a></li>}i, 1]
        if file
          # Only count Plugins with contents
          plugin += "/" + file
          plugins_with_paths << plugin + "\n"
        end
      end

      queue_count += 1
      @hydra.queue(request)

      # the wordpress server stops
      # responding if we dont use this.
      if queue_count == @browser.max_threads
         @hydra.run
         queue_count = 0
      end

    end

    @hydra.run

    plugins_with_paths
  end

  # Save the file

  def save_file(full=false)
    begin
      if (full)
        plugins = parse_full_plugins
      else
        plugins = parse_popular_plugins
      end
      puts "[*] We have parsed " + plugins.size.to_s
      plugins_with_paths = parse_plugin_files(plugins)
      File.open(DATA_DIR + '/plugins.txt', 'w') { |f| f.write(plugins_with_paths) }
      puts "New data/plugin.txt file created with " + plugins_with_paths.scan(/\n/).size.to_s + " entries."
    rescue => e
      puts "ERROR: Something went wrong :( " + e.inspect
    end
  end

end
