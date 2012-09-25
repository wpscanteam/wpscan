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

module WpTimthumbs

  # Used as cache : nil => timthumbs not checked, [] => no timthumbs, otherwise array of timthumbs url found
  @wp_timthumbs = nil

  def has_timthumbs?(theme_name, options = {})
    !timthumbs(theme_name, options).empty?
  end

  def timthumbs(theme_name = nil, options = {})
    if @wp_timthumbs.nil?
      options[:type]                  = "timthumbs"
      options[:only_vulnerable_ones]  = false
      options[:file]                  = options[:file] || DATA_DIR + "/timthumbs.txt"
      options[:vulns_file]            = "xxx"
      options[:vulns_xpath]           = "xxx"
      options[:vulns_xpath_2]         = "xxx"

      WpOptions.check_options(options)
      if theme_name == nil
        custom_items = nil
      else
        custom_items = targets_url_from_theme(theme_name, options)
      end
      @wp_timthumbs = WpEnumerator.enumerate(options, custom_items)
    end
    @wp_timthumbs
  end

  protected
  def targets_url_from_theme(theme_name, options)
    targets = []
    theme_name = URI.escape(theme_name)

    %w{
      timthumb.php lib/timthumb.php inc/timthumb.php includes/timthumb.php
      scripts/timthumb.php tools/timthumb.php functions/timthumb.php
    }.each do |file|
      targets << WpItem.new(
          :base_url       => options[:base_url],
          :path           => "themes/#{theme_name}/#{file}",
          :wp_content_dir => options[:wp_content_dir],
          :name           => theme_name,
          :vulns_file     => "XX",
          :type           => "timthumbs",
          :wp_plugins_dir => options[:wp_plugins_dir]
      )
    end
    targets
  end

end
