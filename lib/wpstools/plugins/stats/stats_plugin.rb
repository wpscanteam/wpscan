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

class StatsPlugin < Plugin

  def initialize
    super(author: 'WPScanTeam - Christian Mehlmauer')

    register_options(
        ['--stats', '--s', 'Show WpScan Database statistics']
    )
  end

  def run(options = {})
    if options[:stats]
      puts "Wpscan Databse Statistics:"
      puts "--------------------------"
      puts "[#] Total vulnerable plugins: #{vuln_plugin_count}"
      puts "[#] Total vulnerable themes: #{vuln_theme_count}"
      puts "[#] Total plugin vulnerabilities: #{plugin_vulns_count}"
      puts "[#] Total theme vulnerabilities: #{theme_vulns_count}"
      puts "[#] Total plugins to enumerate: #{total_plugins}"
      puts "[#] Total themes to enumerate: #{total_themes}"
      puts
    end
  end

  def vuln_plugin_count(file=PLUGINS_VULNS_FILE)
    xml(file).xpath("count(//plugin)").to_i
  end

  def vuln_theme_count(file=THEMES_VULNS_FILE)
    xml(file).xpath("count(//theme)").to_i
  end

  def plugin_vulns_count(file=PLUGINS_VULNS_FILE)
    xml(file).xpath("count(//vulnerability)").to_i
  end

  def theme_vulns_count(file=THEMES_VULNS_FILE)
    xml(file).xpath("count(//vulnerability)").to_i
  end

  def total_plugins(file=PLUGINS_FULL_FILE)
    lines_in_file(file)
  end

  def total_themes(file=THEMES_FULL_FILE)
    lines_in_file(file)
  end

  def lines_in_file(file)
    IO.readlines(file).size
  end

end
