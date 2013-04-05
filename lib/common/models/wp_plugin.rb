# encoding: UTF-8

require 'wp_plugin/vulnerable'

class WpPlugin < WpItem
  include WpPlugin::Vulnerable

  # Sets the @uri
  #
  # @param [ URI ] target_base_uri The URI of the wordpress blog
  #
  # @return [ void ]
  def forge_uri(target_base_uri)
    @uri = target_base_uri.merge(URI.encode(wp_plugins_dir + '/' + name + '/'))
  end

end
