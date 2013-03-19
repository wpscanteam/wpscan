# encoding: UTF-8

require 'wp_version/findable'
require 'wp_version/vulnerable'
require 'wp_version/output'

class WpVersion < WpItem

  extend  WpVersion::Findable
  include WpVersion::Vulnerable
  include WpVersion::Output

  @@version_xml = WP_VERSIONS_FILE

  # The version number
  attr_accessor :number

  def allowed_options; super << :number << :found_from end

  def self.version_xml
    @@version_xml
  end

  def self.version_xml=(xml)
    if File.exists?(xml)
      @@version_xml = xml
    else
      raise "The file #{xml} does not exist"
    end
  end

end
