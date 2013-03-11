# encoding: UTF-8
#
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

class CheckerPlugin < Plugin

  def initialize
    super(author: 'WPScanTeam - @erwanlr')

    register_options(
      ['--check-vuln-ref-urls', '--cvru', 'Check all the vulnerabilities reference urls for 404'],
      ['--check-local-vulnerable-files LOCAL_DIRECTORY', '--clvf', 'Perform a recursive scan in the LOCAL_DIRECTORY to find vulnerable files or shells']
    )
  end

  def run(options = {})
    if options[:check_vuln_ref_urls]
      check_vuln_ref_urls
    end

    if options[:check_local_vulnerable_files]
      check_local_vulnerable_files(options[:check_local_vulnerable_files])
    end
  end

  def check_vuln_ref_urls
    vuln_ref_files   = [PLUGINS_VULNS_FILE, THEMES_VULNS_FILE, WP_VULNS_FILE]
    error_codes      = [404, 500, 403]
    not_found_regexp = %r{No Results Found|error 404|ID Invalid or Not Found}i

    puts '[+] Checking vulnerabilities reference urls'

    vuln_ref_files.each do |vuln_ref_file|
      xml = xml(vuln_ref_file)

      urls = []
      xml.xpath('//reference').each { |node| urls << node.text }

      urls.uniq!

      dead_urls       = []
      queue_count     = 0
      request_count   = 0
      browser         = Browser.instance
      hydra           = browser.hydra
      number_of_urls  = urls.size

      urls.each do |url|
        request = browser.forge_request(url, { cache_ttl: 0, followlocation: true })
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

  def check_local_vulnerable_files(dir_to_scan)
    if Dir::exist?(dir_to_scan)
      xml_file               = LOCAL_FILES_FILE
      local_hashes           = {}
      file_extension_to_scan = '*.{js,php,swf,html,htm}'

      print '[+] Generating local hashes ... '

      Dir[File::join(dir_to_scan, '**', file_extension_to_scan)].each do |filename|
        sha1sum = Digest::SHA1.file(filename).hexdigest

        if local_hashes.has_key?(sha1sum)
          local_hashes[sha1sum] << filename
        else
          local_hashes[sha1sum] = [filename]
        end
      end

      puts 'done.'

      puts '[+] Checking for vulnerable files ...'

      xml = xml(xml_file)

      xml.xpath('//hash').each do |node|
        sha1sum = node.attribute('sha1').text

        if local_hashes.has_key?(sha1sum)
          local_filenames = local_hashes[sha1sum]
          vuln_title      = node.search('title').text
          vuln_filename   = node.search('file').text
          vuln_refrence   = node.search('reference').text

          puts "  #{vuln_filename} found :"
          puts '  | Location(s):'
          local_filenames.each do |file|
            puts "  |  - #{file}"
          end
          puts '  |'
          puts "  | Title: #{vuln_title}"
          puts "  | Refrence: #{vuln_refrence}" if !vuln_refrence.empty?
          puts
        end
      end

      puts 'done.'

    else
      puts "The supplied directory '#{dir_to_scan}' does not exist"
    end
  end

end
