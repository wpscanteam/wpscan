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

module WpTimthumbs

  # Used as cache : nil => timthumbs not checked, [] => no timthumbs, otherwise array of timthumbs url found
  @wp_timthumbs = nil

  def has_timthumbs?(options = {})
    !timthumbs(options).empty?
  end

  # Available options :
  #   :theme_name
  #   :timthumbs_file
  #   :show_progress_bar - default false
  #
  # return array of string (url of timthumbs found), can be empty
  def timthumbs(options = {})
    if @wp_timthumbs.nil?
      browser           = Browser.instance
      hydra             = browser.hydra
      found_timthumbs   = []
      request_count     = 0
      queue_count       = 0
      targets_url       = timthumbs_targets_url(options)
      show_progress_bar = options[:show_progress_bar] || false

      targets_url.each do |target_url|
        request       = browser.forge_request(target_url, :cache_timeout => 0)
        request_count += 1

        request.on_complete do |response|

          print "\rChecking for " + targets_url.size.to_s + " total timthumb files... #{(request_count * 100) / targets_url.size}% complete." if show_progress_bar

          if response.body =~ /no image specified/i
            found_timthumbs << target_url
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

      @wp_timthumbs = found_timthumbs
    end
    @wp_timthumbs
  end

  # Available options :
  #  :theme_name
  #  :timthumbs_file
  #
  # retrun array of string
  def timthumbs_targets_url(options = {})
    targets        = options[:theme_name] ? targets_url_from_theme(options[:theme_name]) : []
    timthumbs_file = WpTimthumbs.timthumbs_file(options[:timthumbs_file])
    targets        += File.open(timthumbs_file, 'r') {|file| file.readlines.collect{|line| @uri.merge(line.chomp).to_s}}

    targets.uniq!
    # randomize the array to *maybe* help in some crappy IDS/IPS/WAF evasion
    targets.sort_by! { rand }
  end

  def self.timthumbs_file(timthumbs_file_path = nil)
    timthumbs_file_path || DATA_DIR + "/timthumbs.txt"
  end

  protected
  def targets_url_from_theme(theme_name)
    targets    = []
    theme_name = URI.escape(theme_name)

    [
      'timthumb.php', 'lib/timthumb.php', 'inc/timthumb.php', 'includes/timthumb.php',
      'scripts/timthumb.php', 'tools/timthumb.php', 'functions/timthumb.php'
    ].each do |file|
      targets << @uri.merge("wp-content/themes/#{theme_name}/#{file}").to_s
    end
    targets
  end

end
