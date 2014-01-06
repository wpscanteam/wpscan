# encoding: UTF-8

class StatsPlugin < Plugin

  def initialize
    super(author: 'WPScanTeam - Christian Mehlmauer')

    register_options(
        ['--stats', '--s', 'Show WpScan Database statistics']
    )
  end

  def run(options = {})
    if options[:stats]
      puts "WPScan Database Statistics:"
      puts "---------------------------"
      puts "[#] Total WordPress Sites in the World: #{get_wp_installations}"
      puts "[#] Total vulnerable versions: #{vuln_core_count}"
      puts "[#] Total vulnerable plugins: #{vuln_plugin_count}"
      puts "[#] Total vulnerable themes: #{vuln_theme_count}"
      puts "[#] Total version vulnerabilities: #{version_vulns_count}"
      puts "[#] Total plugin vulnerabilities: #{plugin_vulns_count}"
      puts "[#] Total theme vulnerabilities: #{theme_vulns_count}"
      puts "[#] Total plugins to enumerate: #{total_plugins}"
      puts "[#] Total themes to enumerate: #{total_themes}"
      puts
    end
  end

  def vuln_core_count(file=WP_VULNS_FILE)
    xml(file).xpath('count(//wordpress)').to_i
  end

  def vuln_plugin_count(file=PLUGINS_VULNS_FILE)
    xml(file).xpath('count(//plugin)').to_i
  end

  def vuln_theme_count(file=THEMES_VULNS_FILE)
    xml(file).xpath('count(//theme)').to_i
  end

  def version_vulns_count(file=WP_VULNS_FILE)
    xml(file).xpath('count(//vulnerability)').to_i
  end

  def plugin_vulns_count(file=PLUGINS_VULNS_FILE)
    xml(file).xpath('count(//vulnerability)').to_i
  end

  def theme_vulns_count(file=THEMES_VULNS_FILE)
    xml(file).xpath('count(//vulnerability)').to_i
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

  def get_wp_installations()
    page = Nokogiri::HTML(Typhoeus.get('http://en.wordpress.com/stats/').body)
    page.css('span[class="stats-flipper-number"]').text
  end

end
