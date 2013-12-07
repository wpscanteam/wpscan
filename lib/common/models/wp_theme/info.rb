# encoding: UTF-8

class WpTheme < WpItem
  module Info

    attr_reader :theme_name, :theme_uri, :theme_description,
                :theme_author, :theme_author_uri, :theme_template,
                :theme_license, :theme_license_uri, :theme_tags,
                :theme_text_domain

    def parse_style
      style = Browser.get(style_url).body
      @theme_name = parse_style_tag(style, 'Theme Name')
      @theme_uri = parse_style_tag(style, 'Theme URI')
      @theme_description = parse_style_tag(style, 'Description')
      @theme_author = parse_style_tag(style, 'Author')
      @theme_author_uri = parse_style_tag(style, 'Author URI')
      @theme_template = parse_style_tag(style, 'Template')
      @theme_license = parse_style_tag(style, 'License')
      @theme_license_uri = parse_style_tag(style, 'License URI')
      @theme_tags = parse_style_tag(style, 'Tags')
      @theme_text_domain = parse_style_tag(style, 'Text Domain')
    end

    private

    def parse_style_tag(style, tag)
      value = style[/^\s*#{Regexp.escape(tag)}:\s*(.*)/i, 1]
      return value.strip if value
      nil
    end

  end
end
