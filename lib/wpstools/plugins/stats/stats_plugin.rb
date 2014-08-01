# encoding: UTF-8

class StatsPlugin < Plugin

  def initialize
    super(author: 'WPScanTeam - Christian Mehlmauer')

    register_options(
        ['--stats', '-s', 'Show WpScan Database statistics.']
    )
  end

  def run(options = {})
    if options[:stats]
      date_wp = File.mtime(WP_VULNS_FILE)
      date_plugins = File.mtime(PLUGINS_VULNS_FILE)
      date_themes = File.mtime(THEMES_VULNS_FILE)
      date_plugins_full = File.mtime(PLUGINS_FULL_FILE)
      date_themes_full = File.mtime(THEMES_FULL_FILE)

      puts "WPScan Database Statistics:"
      puts "---------------------------"
      puts
      puts "[#] Total vulnerable versions: #{vuln_core_count}"
      puts "[#] Total vulnerable plugins:  #{vuln_plugin_count}"
      puts "[#] Total vulnerable themes:   #{vuln_theme_count}"
      puts
      puts "[#] Total version vulnerabilities: #{version_vulns_count}"
      puts "[#] Total fixed vulnerabilities:   #{fix_version_count}"
      puts
      puts "[#] Total plugin vulnerabilities:  #{plugin_vulns_count}"
      puts "[#] Total fixed vulnerabilities:   #{fix_plugin_count}"
      puts
      puts "[#] Total theme vulnerabilities:   #{theme_vulns_count}"
      puts "[#] Total fixed vulnerabilities:   #{fix_theme_count}"
      puts
      puts "[#] Total plugins to enumerate:  #{total_plugins}"
      puts "[#] Total themes to enumerate:   #{total_themes}"
      puts
      puts "[+] WordPress DB modified: #{date_wp.strftime('%Y-%m-%d %H:%M:%S')}"
      puts "[+] Plugins DB modified:   #{date_plugins.strftime('%Y-%m-%d %H:%M:%S')}"
      puts "[+] Themes DB modified:    #{date_themes.strftime('%Y-%m-%d %H:%M:%S')}"
      puts "[+] Enumeration plugins:   #{date_plugins_full.strftime('%Y-%m-%d %H:%M:%S')}"
      puts "[+] Enumeration themes:    #{date_themes_full.strftime('%Y-%m-%d %H:%M:%S')}"
      puts
      puts "[+] Report generated:      #{Time.now.strftime('%Y-%m-%d %H:%M:%S')}"
    end
  end

  def vuln_core_count(file=WP_VULNS_FILE)
    json(file).size
  end

  def vuln_plugin_count(file=PLUGINS_VULNS_FILE)
    json(file).size
  end

  def vuln_theme_count(file=THEMES_VULNS_FILE)
    json(file).size
  end

  def version_vulns_count(file=WP_VULNS_FILE)
    asset_vulns_count(json(file))
  end

  def fix_version_count(file=WP_VULNS_FILE)
    asset_fixed_in_count(json(file))
  end

  def plugin_vulns_count(file=PLUGINS_VULNS_FILE)
    asset_vulns_count(json(file))
  end

  def fix_plugin_count(file=PLUGINS_VULNS_FILE)
    asset_fixed_in_count(json(file))
  end

  def theme_vulns_count(file=THEMES_VULNS_FILE)
    asset_vulns_count(json(file))
  end

  def fix_theme_count(file=THEMES_VULNS_FILE)
    asset_fixed_in_count(json(file))
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

  def asset_vulns_count(json)
    json.map { |asset| asset[asset.keys.inject]['vulnerabilities'].size }.inject(:+)
  end

  def asset_fixed_in_count(json)
    json.map { |asset| asset[asset.keys.inject]['vulnerabilities'].map {|a| a['fixed_in'].nil? ? 0 : 1 }.inject(:+) }.inject(:+)
  end

end
