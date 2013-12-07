# encoding: UTF-8

class WpTheme
	module Output

		# @return [ Void ]
		def additional_output
			puts " | Style URL: #{style_url}"
			puts " | Theme Name: #@theme_name" if @theme_name
			puts " | Theme URI: #@theme_uri" if @theme_uri
			puts " | Description: #@theme_description" if @theme_description
			puts " | Author: #@theme_author" if @theme_author
			puts " | Author URI: #@theme_author_uri" if @theme_author_uri
			puts " | Template: #@theme_template" if @theme_template
			puts " | License: #@theme_license" if @theme_license_uri
			puts " | Tags: #@theme_tags" if @theme_tags
			puts " | Text Domain: #@theme_text_domain" if @theme_text_domain
		end

	end
end
