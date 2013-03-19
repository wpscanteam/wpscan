# encoding: UTF-8

class WpPlugin < WpItem
  include WpPlugin::Vulnerable

  def forge_uri(target_base_uri)
    @uri = target_base_uri.merge(URI.encode(wp_plugins_dir) + '/' + URI.encode(name) + '/')
  end

end
