# encoding: UTF-8

class WpVersion < WpItem

  module Findable

    # Find the version of the blog designated from target_uri
    #
    # @param [ URI ] target_uri
    # @param [ String ] wp_content_dir
    # @param [ String ] wp_plugins_dir
    #
    # @return [ WpVersion ]
    def find(target_uri, wp_content_dir, wp_plugins_dir, versions_xml)
      versions = {}
      methods.grep(/^find_from_/).each do |method|

        if method === :find_from_advanced_fingerprinting
          version = send(method, target_uri, wp_content_dir, wp_plugins_dir, versions_xml)
        else
          version = send(method, target_uri)
        end

        if version
          if versions.key?(version)
            versions[version] << method.to_s
          else
            versions[version] = [ method.to_s ]
          end
        end
      end

      if versions.length > 0
        determined_version = versions.max_by { |k, v| v.length }
        if determined_version
          return new(target_uri, number: determined_version[0], found_from: determined_version[1].join(', '))
        end
      end

      nil
    end

    # Used to check if the version is correct: must contain at least one dot.
    #
    # @return [ String ]
    def version_pattern
      '([^\r\n"\',]+\.[^\r\n"\',]+)'
    end

    protected

    # Returns the first match of <pattern> in the body of the url
    #
    # @param [ URI ] target_uri
    # @param [ Regex ] pattern
    # @param [ String ] path
    #
    # @return [ String ]
    def scan_url(target_uri, pattern, path = nil)
      url = path ? target_uri.merge(path).to_s : target_uri.to_s
      response = Browser.get_and_follow_location(url)

      response.body[pattern, 1]
    end

    #
    # DO NOT Change the order of the following methods
    # unless you know what you are doing
    # See WpVersion.find
    #

    # Attempts to find the wordpress version from,
    # the generator meta tag in the html source.
    #
    # The meta tag can be removed however it seems,
    # that it is reinstated on upgrade.
    #
    # @param [ URI ] target_uri
    #
    # @return [ String ] The version number
    def find_from_meta_generator(target_uri)
      scan_url(
        target_uri,
        %r{name="generator" content="wordpress #{version_pattern}.*"}i
      )
    end

    # Attempts to find the WordPress version from,
    # the generator tag in the RSS feed source.
    #
    # @param [ URI ] target_uri
    #
    # @return [ String ] The version number
    def find_from_rss_generator(target_uri)
      scan_url(
        target_uri,
        %r{<generator>http://wordpress.org/\?v=#{version_pattern}</generator>}i,
        'feed/'
      )
    end

    # Attempts to find WordPress version from,
    # the generator tag in the RDF feed source.
    #
    # @param [ URI ] target_uri
    #
    # @return [ String ] The version number
    def find_from_rdf_generator(target_uri)
      scan_url(
        target_uri,
        %r{<admin:generatorAgent rdf:resource="http://wordpress.org/\?v=#{version_pattern}" />}i,
        'feed/rdf/'
      )
    end

    # Attempts to find the WordPress version from,
    # the generator tag in the Atom source.
    #
    # @param [ URI ] target_uri
    #
    # @return [ String ] The version number
    def find_from_atom_generator(target_uri)
      scan_url(
        target_uri,
        %r{<generator uri="http://wordpress.org/" version="#{version_pattern}">WordPress</generator>}i,
        'feed/atom/'
      )
    end

    # Uses data/wp_versions.xml to try to identify a
    # wordpress version.
    #
    # It does this by using client side file hashing
    #
    # /!\ Warning : this method might return false positive if the file used for fingerprinting is part of a theme (they can be updated)
    #
    # @param [ URI ] target_uri
    # @param [ String ] wp_content_dir
    # @param [ String ] wp_plugins_dir
    # @param [ String ] versions_xml The path to the xml containing all versions
    #
    # @return [ String ] The version number
    def find_from_advanced_fingerprinting(target_uri, wp_content_dir, wp_plugins_dir, versions_xml)
      xml     = xml(versions_xml)

      wp_item = WpItem.new(target_uri,
                           wp_content_dir: wp_content_dir,
                           wp_plugins_dir: wp_plugins_dir)

      xml.xpath('//file').each do |node|
        wp_item.path = node.attribute('src').text

        response = Browser.get(wp_item.url)
        md5sum = Digest::MD5.hexdigest(response.body)

        node.search('hash').each do |hash|
          if hash.attribute('md5').text == md5sum
            return hash.search('version').text
          end
        end
      end
      nil
    end

    # Attempts to find the WordPress version from the readme.html file.
    #
    # @param [ URI ] target_uri
    #
    # @return [ String ] The version number
    def find_from_readme(target_uri)
      scan_url(
        target_uri,
        %r{<br />\sversion #{version_pattern}}i,
        'readme.html'
      )
    end

    # Attempts to find the WordPress version from the sitemap.xml file.
    #
    # @param [ URI ] target_uri
    #
    # @return [ String ] The version number
    def find_from_sitemap_generator(target_uri)
      scan_url(
        target_uri,
        %r{generator="wordpress/#{version_pattern}"}i,
        'sitemap.xml'
      )
    end

    # Attempts to find the WordPress version from the p-links-opml.php file.
    #
    # @param [ URI ] target_uri
    #
    # @return [ String ] The version number
    def find_from_links_opml(target_uri)
      scan_url(
        target_uri,
        %r{generator="wordpress/#{version_pattern}"}i,
        'wp-links-opml.php'
      )
    end

    def find_from_stylesheets_numbers(target_uri)
      wp_versions = WpVersion.all
      found       = {}
      pattern     = /\bver=([0-9\.]+)/i

      Nokogiri::HTML(Browser.get(target_uri.to_s).body).css('link,script').each do |tag|
        %w(href src).each do |attribute|
          attr_value = tag.attribute(attribute).to_s

          next if attr_value.nil? || attr_value.empty?

          begin
            uri = Addressable::URI.parse(attr_value)
          rescue Addressable::URI::InvalidURIError
            next
          end

          next unless uri.query && uri.query.match(pattern)

          version = Regexp.last_match[1].to_s

          found[version] ||= 0
          found[version] += 1
        end
      end

      found.delete_if { |v, _| !wp_versions.include?(v) }

      best_guess = found.sort_by(&:last).last
      # best_guess[0]: version number, [1] numbers of occurences
      best_guess && best_guess[1] > 1 ? best_guess[0] : nil
    end
  end
end
