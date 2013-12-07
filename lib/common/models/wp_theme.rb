# encoding: UTF-8

require 'wp_theme/findable'
require 'wp_theme/versionable'
require 'wp_theme/vulnerable'
require 'wp_theme/info'
require 'wp_theme/output'

class WpTheme < WpItem
  extend WpTheme::Findable
  include WpTheme::Versionable
  include WpTheme::Vulnerable
	include WpTheme::Info
	include WpTheme::Output

  attr_writer :style_url

  def allowed_options; super << :style_url end

	def initialize(*args)
		super(*args)

		parse_style
	end

  # Sets the @uri
  #
  # @param [ URI ] target_base_uri The URI of the wordpress blog
  #
  # @return [ void ]
  def forge_uri(target_base_uri)
    @uri = target_base_uri.merge(URI.encode(wp_content_dir + '/themes/' + name + '/'))
  end

  # @return [ String ] The url to the theme stylesheet
  def style_url
    unless @style_url
      @style_url = uri.merge('style.css').to_s
    end
    @style_url
	end

end
