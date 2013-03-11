# encoding: UTF-8
#--
# WPScan - WordPress Security Scanner
# Copyright (C) 2012-2013
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#++

require "wpscan/vulnerable"

class WpVersion < Vulnerable

  attr_reader :number, :discovery_method

  def initialize(number, options = {})
    @number           = number
    @discovery_method = options[:discovery_method]
    @vulns_file       = options[:vulns_file] || WP_VULNS_FILE
    @vulns_xpath      = "//wordpress[@version='#{@number}']/vulnerability"
  end

  # Will use all method self.find_from_* to try to detect the version
  # Once the version is found, it will return a WpVersion object
  # The method_name will be without 'find_from_' and '_' will be replace by ' ' (IE 'meta generator', 'rss generator' etc)
  # If the version is not found, nil is returned
  #
  # The order in which the find_from_* methods are is important, they will be called in the same order
  # (find_from_meta_generator, find_from_rss_generator etc)
  def self.find(target_uri, wp_content_dir)
    options = {
      base_uri:       target_uri,
      wp_content_dir: wp_content_dir
    }
    self.methods.grep(/find_from_/).each do |method_to_call|
      version = self.send(method_to_call, options)

      if version
        return new(version, discovery_method: method_to_call[%r{find_from_(.*)}, 1].gsub('_', ' '))
      end
    end
    nil
  end

  protected

  # Returns the first match in the body of the url
  def self.scan_url_for_pattern(base_uri, pattern, path = nil)
    url     = path ? base_uri.merge(path).to_s : base_uri.to_s
    response = Browser.instance.get_and_follow_location(url)

    response.body[pattern, 1]
  end

  # Attempts to find the wordpress version from,
  # the generator meta tag in the html source.
  #
  # The meta tag can be removed however it seems,
  # that it is reinstated on upgrade.
  def self.find_from_meta_generator(options)
    WpVersion.scan_url_for_pattern(
      options[:base_uri],
      %r{name="generator" content="wordpress #{WpVersion.version_pattern}"}i
    )
  end

  # Attempts to find the WordPress version from,
  # the generator tag in the RSS feed source.
  def self.find_from_rss_generator(options)
    WpVersion.scan_url_for_pattern(
      options[:base_uri],
      %r{<generator>http://wordpress.org/\?v=#{WpVersion.version_pattern}</generator>}i,
      'feed/'
    )
  end

  # Attempts to find WordPress version from,
  # the generator tag in the RDF feed source.
  def self.find_from_rdf_generator(options)
    WpVersion.scan_url_for_pattern(
      options[:base_uri],
      %r{<admin:generatorAgent rdf:resource="http://wordpress.org/\?v=#{WpVersion.version_pattern}" />}i,
      'feed/rdf/'
    )
  end

  # Attempts to find the WordPress version from,
  # the generator tag in the RSS2 feed source.
  #
  # Have not been able to find an example of this - Ryan
  #def self.find_from_rss2_generator(options)
  #  WpVersion.scan_url_for_pattern(
  #    options[:base_uri],
  #    %r{<generator>http://wordpress.org/?v=(#{WpVersion.version_pattern})</generator>}i,
  #    'feed/rss/'
  #  )
  #end

  # Attempts to find the WordPress version from,
  # the generator tag in the Atom source.
  def self.find_from_atom_generator(options)
    WpVersion.scan_url_for_pattern(
      options[:base_uri],
      %r{<generator uri="http://wordpress.org/" version="#{WpVersion.version_pattern}">WordPress</generator>}i,
      'feed/atom/'
    )
  end

  # Attempts to find the WordPress version from,
  # the generator tag in the comment rss source.
  #
  # Have not been able to find an example of this - Ryan
  #def self.find_from_comments_rss_generator(options)
  #  WpVersion.scan_url_for_pattern(
  #    options[:base_uri],
  #    %r{<!-- generator="WordPress/#{WpVersion.version_pattern}" -->}i,
  #    'comments/feed/'
  #  )
  #end

  # Uses data/wp_versions.xml to try to identify a
  # wordpress version.
  #
  # It does this by using client side file hashing
  #
  #  /!\ Warning : this method might return false positive if the file used for fingerprinting is part of a theme (they can be updated)
  #
  def self.find_from_advanced_fingerprinting(options)
    target_uri  = options[:base_uri]
    version_xml = options[:version_xml] || WP_VERSIONS_FILE # needed for rpsec
    wp_content  = options[:wp_content_dir]
    wp_plugins  = "#{wp_content}/plugins"

    xml = Nokogiri::XML(File.open(version_xml)) do |config|
      config.noblanks
    end

    xml.xpath('//file').each do |node|
      file_url = target_uri.merge(node.attribute('src').text).to_s
      file_url = file_url.gsub(/\$wp-plugins\$/i, wp_plugins).gsub(/\$wp-content\$/i, wp_content)
      md5sum   = Digest::MD5.hexdigest(Browser.instance.get(file_url).body)

      node.search('hash').each do |hash|
        if hash.attribute('md5').text == md5sum
          return hash.search('version').text
        end
      end
    end
    nil
  end

  # Attempts to find the WordPress version from the readme.html file.
  def self.find_from_readme(options)
    WpVersion.scan_url_for_pattern(
      options[:base_uri],
      %r{<br />\sversion #{WpVersion.version_pattern}}i,
      'readme.html'
    )
  end

  # Attempts to find the WordPress version from the sitemap.xml file.
  #
  # See: http://code.google.com/p/wpscan/issues/detail?id=109
  def self.find_from_sitemap_generator(options)
    WpVersion.scan_url_for_pattern(
      options[:base_uri],
      %r{generator="wordpress/#{WpVersion.version_pattern}"}i,
      'sitemap.xml'
    )
  end

  # Attempts to find the WordPress version from the p-links-opml.php file.
  def self.find_from_links_opml(options)
    WpVersion.scan_url_for_pattern(
      options[:base_uri],
      %r{generator="wordpress/#{WpVersion.version_pattern}"}i,
      'wp-links-opml.php'
    )
  end

  # Used to check if the version is correct: must contain at least one dot.
  def self.version_pattern
    '([^\r\n"\']+\.[^\r\n"\']+)'
  end
end
