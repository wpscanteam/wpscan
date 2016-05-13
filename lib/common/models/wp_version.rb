# encoding: UTF-8

require 'wp_version/findable'
require 'wp_version/output'

class WpVersion < WpItem
  extend  WpVersion::Findable
  include WpVersion::Output

  # The version number
  attr_accessor :number, :metadata
  alias_method :version, :number # Needed to have the right behaviour in Vulnerable#vulnerable_to?

  # @return [ Array ]
  def allowed_options; super << :number << :found_from end

  def identifier
    @identifier ||= number
  end

  def db_file
    @db_file ||= WORDPRESSES_FILE
  end

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

  # @return [ Hash ] Metadata for specific WP version from WORDPRESSES_FILE
  def metadata(version)
    json = json(db_file)

    metadata = {}
    temp = json[version]
    if !temp.nil?
      metadata[:release_date]  = temp['release_date']
      metadata[:changelog_url] = temp['changelog_url']
    end
    metadata
  end
end
