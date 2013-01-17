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

class ListGeneratorPlugin < Plugin

  def initialize
    super(
      :author => "WPScanTeam - @FireFart"
    )

    register_options(
      ["--generate-plugin-list [NUMBER_OF_PAGES]", "--gpl", Integer, "Generate a new data/plugins.txt file. (supply number of *pages* to parse, default : 150)"],
      ["--generate-full-plugin-list", "--gfpl", "Generate a new full data/plugins.txt file"],

      ["--generate-theme-list [NUMBER_OF_PAGES]", "--gtl", Integer, "Generate a new data/themes.txt file. (supply number of *pages* to parse, default : 150)"],
      ["--generate-full-theme-list", "--gftl", "Generate a new full data/themes.txt file"],

      ["--generate-all", "--ga", "Generate a new full plugins, full themes, popular plugins and popular themes list"],
    )
  end

  def run(options = {})
    verbose      = options[:verbose] || false
    generate_all = options[:generate_all] || false

    if options.has_key?(:generate_plugin_list) || generate_all
      number_of_pages = options[:generate_plugin_list] || 150

      puts "[+] Generating new most popular plugin list"
      puts
      GenerateList.new('plugins', verbose).generate_popular_list(number_of_pages)
    end

    if options[:generate_full_plugin_list] || generate_all
      puts "[+] Generating new full plugin list"
      puts
      GenerateList.new('plugins', verbose).generate_full_list
    end

    if options.has_key?(:generate_theme_list) || generate_all
      number_of_pages = options[:generate_theme_list] || 150

      puts "[+] Generating new most popular theme list"
      puts
      GenerateList.new('themes', verbose).generate_popular_list(number_of_pages)
    end

    if options[:generate_full_theme_list] || generate_all
      puts "[+] Generating new full theme list"
      puts
      GenerateList.new('themes', verbose).generate_full_list
    end
  end

end
