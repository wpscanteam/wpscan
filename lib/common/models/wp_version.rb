# encoding: UTF-8

require 'wp_version/findable'
require 'wp_version/vulnerable'
require 'wp_version/output'

class WpVersion < WpItem

  extend  WpVersion::Findable
  include WpVersion::Vulnerable
  include WpVersion::Output

  # The version number
  attr_accessor :number

  # @return [ Array ]
  def allowed_options; super << :number << :found_from end

  # @param [ WpVersion ] other
  #
  # @return [ Boolean ]
  def ==(other)
    number == other.number
  end

  # @return [ Array<String> ] All the stable versions from version_file
  def self.all(versions_file = WP_VERSIONS_FILE)
    Nokogiri.XML(File.open(versions_file)).css('version').reduce([]) do |a, node|
      a << node.text.to_s
    end
  end

end
