#!/usr/bin/env ruby

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

$: << '.'
require File.dirname(__FILE__) +'/lib/wpstools/wpstools_helper'

begin

  banner()

  if ARGV.length == 0
    raise "No argument supplied\n#{usage()}"
  end

  # A better way to do that should be to create a wpstools_options.rb file like wpscan_options.rb
  # and a wps_options.rb with common options code
  options = GetoptLong.new(
      ["--help", "-h", GetoptLong::NO_ARGUMENT],
      ["--verbose", "-v", GetoptLong::NO_ARGUMENT],
      ["--generate_plugin_list", GetoptLong::OPTIONAL_ARGUMENT],
      ["--generate_full_plugin_list", GetoptLong::NO_ARGUMENT],
      ["--generate_theme_list", GetoptLong::OPTIONAL_ARGUMENT],
      ["--generate_full_theme_list", GetoptLong::NO_ARGUMENT],
      ["--generate_all", GetoptLong::NO_ARGUMENT],
      ["--gpl", GetoptLong::OPTIONAL_ARGUMENT],           # Alias for --generate_plugin_list
      ["--gfpl", GetoptLong::OPTIONAL_ARGUMENT],          # Alias for --generate_full_plugin_list
      ["--gtl", GetoptLong::OPTIONAL_ARGUMENT],           # Alias for --generate_theme_list
      ["--gftl", GetoptLong::OPTIONAL_ARGUMENT],          # Alias for --generate_full_theme_list
      ["--ga", GetoptLong::OPTIONAL_ARGUMENT],            # Alias for --generate_all
      ["--update", "-u", GetoptLong::NO_ARGUMENT],
      ["--check-vuln-ref-urls", GetoptLong::NO_ARGUMENT],
      ["--cvru", GetoptLong::NO_ARGUMENT]                 # Alias for --check-vuln-ref-urls
  )

  options.each do |option, argument|
    case option
      when "--help"
        help()
        exit
      when "--verbose"
        @verbose = true
      when "--generate_plugin_list", "--gpl"
        if argument == ''
          puts "Number of pages not supplied, defaulting to 150 pages ..."
          @number_of_pages = 150
        else
          @number_of_pages = argument.to_i
        end

        @generate_plugin_list = true
      when "--generate_theme_list", "--gtl"
        if argument == ''
          puts "Number of pages not supplied, defaulting to 150 pages ..."
          @number_of_pages = 150
        else
          @number_of_pages = argument.to_i
        end

        @generate_theme_list = true
      when "--update"
        @update = true
      when "--generate_full_plugin_list", "--gfpl"
        @generate_full_plugin_list = true
      when "--generate_full_theme_list", "--gftl"
        @generate_full_theme_list = true
      when "--generate_all", "--ga"
        @generate_plugin_list      = true
        @generate_theme_list       = true
        @number_of_pages           = 150
        @generate_full_theme_list  = true
        @generate_full_plugin_list = true
      when "--check-vuln-ref-urls", "--cvru"
        @check_vuln_ref_urls = true
    end
  end

  if @generate_plugin_list
    puts "[+] Generating new most popular plugin list"
    puts
    Generate_List.new('plugins', @verbose).generate_popular_list(@number_of_pages)
  end

  if @generate_full_plugin_list
    puts "[+] Generating new full plugin list"
    puts
    Generate_List.new('plugins', @verbose).generate_full_list
  end

  if @generate_theme_list
    puts "[+] Generating new most popular theme list"
    puts
    Generate_List.new('themes', @verbose).generate_popular_list(@number_of_pages)
  end

  if @generate_full_theme_list
    puts "[+] Generating new full theme list"
    puts
    Generate_List.new('themes', @verbose).generate_full_list
  end

  # seclists.org redirects to the homepage if the reference does not exist
  # TODO : the special case above
  if @check_vuln_ref_urls
    vuln_ref_files   = ["plugin_vulns.xml", "wp_theme_vulns.xml", "wp_vulns.xml"]
    error_codes      = [404, 500, 403]
    not_found_regexp = %r{No Results Found|error 404|ID Invalid or Not Found}i

    puts "[+] Checking vulnerabilities reference urls"

    vuln_ref_files.each do |vuln_ref_file|
      xml = Nokogiri::XML(File.open(DATA_DIR + '/' + vuln_ref_file)) do |config|
        config.noblanks
      end

      urls = []
      xml.xpath("//reference").each { |node| urls << node.text }

      urls.uniq!

      dead_urls       = []
      queue_count     = 0
      request_count   = 0
      browser         = Browser.instance
      hydra           = browser.hydra
      number_of_urls  = urls.size

      urls.each do |url|
        request = browser.forge_request(url, { :cache_timeout => 0, :follow_location => true })
        request_count += 1

        request.on_complete do |response|
          print "\r  [+] Checking #{vuln_ref_file} #{number_of_urls} total ... #{(request_count * 100) / number_of_urls}% complete."

          if error_codes.include?(response.code) or not_found_regexp.match(response.body)
            dead_urls << url
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
      puts
      unless dead_urls.empty?
        dead_urls.each { |url| puts "    Not Found #{url}" }
      end
    end
  end

  if @update
    unless @updater.nil?
      puts @updater.update()
    else
      puts "Svn / Git not installed, or wpscan has not been installed with one of them."
      puts "Update aborted"
    end
  end

rescue => e
  puts "[ERROR] #{e.message}"
  puts "Trace :"
  puts e.backtrace.join("\n")
end
