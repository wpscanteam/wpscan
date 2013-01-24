# encoding: UTF-8
#--
# WPScan - WordPress Security Scanner
# Copyright (C) 2012-2013
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

# This tool generates a list to use for plugin and theme enumeration
class GenerateList

  attr_accessor :verbose

  # type = themes | plugins
  def initialize(type, verbose)
    if type =~ /plugins/i
      @type           = 'plugin'
      @svn_url        = 'http://plugins.svn.wordpress.org/'
      @popular_url    = 'http://wordpress.org/extend/plugins/browse/popular/'
      @popular_regex  = %r{<h3><a href="http://wordpress.org/extend/plugins/(.+)/">.+</a></h3>}i
    elsif type =~ /themes/i
      @type           = 'theme'
      @svn_url        = 'http://themes.svn.wordpress.org/'
      @popular_url    = 'http://wordpress.org/extend/themes/browse/popular/'
      @popular_regex  = %r{<h3><a href="http://wordpress.org/extend/themes/(.+)">.+</a></h3>}i
    else
      raise "Type #{type} not defined"
    end
    @verbose  = verbose
    @browser  = Browser.instance
    @hydra    = @browser.hydra
  end

  def set_file_name(type)
    case @type
    when 'plugin'
      case type
      when :full
        @file_name = PLUGINS_FULL_FILE
      when :popular
        @file_name = PLUGINS_FILE
      else
        raise 'Unknown type'
      end
    when 'theme'
      case type
      when :full
        @file_name = THEMES_FULL_FILE
      when :popular
        @file_name = THEMES_FILE
      else
        raise 'Unknown type'
      end
      else
        raise "Unknown type #@type"
    end
  end

  def generate_full_list
    set_file_name(:full)
    items = SvnParser.new(@svn_url).parse
    save items
  end

  def generate_popular_list(pages)
    set_file_name(:popular)
    items = get_popular_items(pages)
    save items
  end

  # Send a HTTP request to the WordPress most popular theme or plugin webpage
  # parse the response for the names.
  def get_popular_items(pages)
    found_items = []
    page_count = 1
    queue_count = 0

    (1...(pages.to_i + 1)).each do |page|
      # First page has another URL
      url = (page == 1) ? @popular_url : @popular_url + 'page/' + page.to_s + '/'
      request = @browser.forge_request(url)

      queue_count += 1

      request.on_complete do |response|
        puts "[+] Parsing page #{page_count}" if @verbose
        page_count += 1
        response.body.scan(@popular_regex).each do |item|
          puts "[+] Found popular #@type: #{item}" if @verbose
          found_items << item[0]
        end
      end

      @hydra.queue(request)

      if queue_count == @browser.max_threads
        @hydra.run
        queue_count = 0
      end

    end

    @hydra.run

    found_items.sort!
    found_items.uniq
  end

  # Save the file
  def save(items)
    items.sort!
    items.uniq!
    puts "[*] We have parsed #{items.length} #@types"
    File.open(@file_name, 'w') { |f| f.puts(items) }
    puts "New #@file_name file created"
  end

end
