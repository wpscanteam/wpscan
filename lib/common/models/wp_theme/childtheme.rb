# encoding: UTF-8

class WpTheme < WpItem
  module Childtheme

    def parent_theme_limit
      3
    end

    def is_child_theme?
      return true unless @theme_template.nil?
      false
    end

    def get_parent_theme_style_url
      if is_child_theme?
        return style_url.sub("/#{name}/style.css", "/#{@theme_template}/style.css")
      end
      nil
    end

    def get_parent_theme
      if is_child_theme?
        base_url = @uri.clone
        base_url.path = base_url.path.sub(/(?<url>.*\/)#{Regexp.escape(@wp_content_dir)}\/.+/, '\k<url>')
        return WpTheme.new(base_url,
                           {
                               name: @theme_template,
                               style_url: get_parent_theme_style_url,
                               wp_content_dir: @wp_content_dir
                           })
      end
      nil
    end

  end
end
