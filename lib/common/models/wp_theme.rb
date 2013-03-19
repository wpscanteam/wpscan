# encoding: UTF-8

require 'wp_theme/findable'
require 'wp_theme/versionable'

class WpTheme < WpItem
  extend WpTheme::Findable
  include WpTheme::Versionable
  include WpTheme::Vulnerable

  attr_writer :style_url

  def allowed_options; super << :style_url end

  def forge_uri(target_base_uri)
    @uri = target_base_uri.merge(URI.encode(wp_content_dir + '/themes/' + name + '/')) # make suer that this last / is present (spec)
  end

  def style_url
    unless @style_url
      @style_url = uri.merge('style.css').to_s
    end
    @style_url
  end

end
