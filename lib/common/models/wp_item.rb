# encoding: UTF-8

require 'wp_item/findable'
require 'wp_item/versionable'
require 'wp_item/vulnerable'
require 'wp_item/existable'
require 'wp_item/infos'
require 'wp_item/output'

class WpItem

  extend  WpItem::Findable
  include WpItem::Versionable
  include WpItem::Vulnerable
  include WpItem::Existable
  include WpItem::Infos
  include WpItem::Output

  attr_reader   :path
  attr_accessor :name, :wp_content_dir, :wp_plugins_dir, :wp_local_dir

  # @return [ Array ]
  # Make it private ?
  def allowed_options
    [:name, :wp_content_dir, :wp_plugins_dir, :wp_local_dir, :path, :version, :db_file]
  end

  # @param [ URI ] target_base_uri
  # @param [ Hash ] options See allowed_option
  #
  # @return [ WpItem ]
  def initialize(target_base_uri, options = {})
    options[:wp_content_dir] ||= 'wp-content'
    options[:wp_plugins_dir] ||= options[:wp_content_dir] + '/plugins'
    options[:wp_local_dir]   ||= ''

    set_options(options)
    forge_uri(target_base_uri)
  end

  def identifier
    @identifier ||= name
  end

  # @return [ Hash ]
  def db_data
    @db_data ||= json(db_file)[identifier] || {}
  end

  def latest_version
    db_data['latest_version']
  end

  def last_updated
    db_data['last_ipdated']
  end

  def popular?
    db_data['popular']
  end

  # @param [ Hash ] options
  #
  # @return [ void ]
  def set_options(options)
    allowed_options.each do |allowed_option|
      if options.has_key?(allowed_option)
        method = :"#{allowed_option}="

        if self.respond_to?(method)
          self.send(method, options[allowed_option])
        else
          raise "#{self.class} does not respond to #{method}"
        end
      end
    end
  end
  private :set_options

  # @param [ URI ] target_base_uri
  #
  # @return [ void ]
  def forge_uri(target_base_uri)
    @uri = target_base_uri
  end

  # @return [ URI ] The uri to the WpItem, with the path if present
  def uri
    path ? @uri.merge(path) : @uri
  end

  # @return [ String ] The url to the WpItem
  def url; uri.to_s end

  # Sets the path
  #
  # Variable, such as $wp-plugins$ and $wp-content$ can be used
  # and will be replace by their value
  #
  # @param [ String ] path
  #
  # @return [ void ]
  def path=(path)
    @path = URI.encode(
      path.gsub(/\$wp-plugins\$/i, wp_plugins_dir).gsub(/\$wp-content\$/i, wp_content_dir)
    )
  end

  # @param [ WpItem ] other
  def <=>(other)
    name <=> other.name
  end

  # @param [ WpItem ] other
  def ==(other)
    name === other.name
  end

  # @param [ WpItem ] other
  def ===(other)
    self == other && version === other.version
  end

end
