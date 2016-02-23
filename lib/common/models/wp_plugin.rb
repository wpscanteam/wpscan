# encoding: UTF-8

class WpPlugin < WpItem
  # Sets the @uri
  #
  # @param [ URI ] target_base_uri The URI of the wordpress blog
  #
  # @return [ void ]
  def forge_uri(target_base_uri)
    @uri = target_base_uri.merge("#{wp_plugins_dir}/#{url_encode(name)}/")
  end

  def db_file
    @db_file ||= PLUGINS_FILE
  end
end
