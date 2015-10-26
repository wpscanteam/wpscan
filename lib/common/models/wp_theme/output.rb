# encoding: UTF-8

class WpTheme
  module Output

    # @return [ Void ]
    def additional_output(verbose = false)
      parse_style

      theme_desc = verbose ? @theme_description : truncate(@theme_description, 100)
      puts " |  Style URL: #{style_url}"
      puts " |  Referenced style.css: #{referenced_url}" if referenced_url && referenced_url != style_url
      puts " |  Theme Name: #{@theme_name}" if @theme_name
      puts " |  Theme URI: #{@theme_uri}" if @theme_uri
      puts " |  Description: #{theme_desc}" if theme_desc
      puts " |  Author: #{@theme_author}" if @theme_author
      puts " |  Author URI: #{@theme_author_uri}" if @theme_author_uri
      puts " |  Template: #{@theme_template}" if @theme_template and verbose
      puts " |  License: #{@theme_license}" if @theme_license and verbose
      puts " |  License URI: #{@theme_license_uri}" if @theme_license_uri and verbose
      puts " |  Tags: #{@theme_tags}" if @theme_tags and verbose
      puts " |  Text Domain: #{@theme_text_domain}" if @theme_text_domain and verbose
    end

  end
end
