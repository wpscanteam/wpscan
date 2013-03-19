# encoding: UTF-8

class WpVersion < WpItem
  module Findable

    # Find the version of the wp_target blog
    # returns a WpVersion object or nil
    def find(target_uri, wp_content_dir, wp_plugins_dir)
      methods.grep(/find_from_/).each do |method|
        if version = send(method, target_uri, wp_content_dir, wp_plugins_dir)

          return new(target_uri, number: version, found_from: method)
        end
      end
    end

    # Returns the first match of <pattern> in the body of the url
    def scan_url(target_uri, pattern, path = nil)
      url = path ? target_uri.merge(path).to_s : target_uri.to_s
      response = Browser.instance.get_and_follow_location(url)

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
    def find_from_meta_generator(target_uri, wp_content_dir, wp_plugins_dir)
      scan_url(
        target_uri,
        %r{name="generator" content="wordpress #{version_pattern}"}i
      )
    end

    # Attempts to find the WordPress version from,
    # the generator tag in the RSS feed source.
    def find_from_rss_generator(target_uri, wp_content_dir, wp_plugins_dir)
      scan_url(
        target_uri,
        %r{<generator>http://wordpress.org/\?v=#{version_pattern}</generator>}i,
        'feed/'
      )
    end

    # Attempts to find WordPress version from,
    # the generator tag in the RDF feed source.
    def find_from_rdf_generator(target_uri, wp_content_dir, wp_plugins_dir)
      scan_url(
        target_uri,
        %r{<admin:generatorAgent rdf:resource="http://wordpress.org/\?v=#{version_pattern}" />}i,
        'feed/rdf/'
      )
    end

    # Attempts to find the WordPress version from,
    # the generator tag in the RSS2 feed source.
    #
    # Have not been able to find an example of this - Ryan
    #def find_from_rss2_generator(target_uri, wp_content_dir, wp_plugins_dir)
    #  scan_url(
    #    target_uri,
    #    %r{<generator>http://wordpress.org/?v=(#{WpVersion.version_pattern})</generator>}i,
    #    'feed/rss/'
    #  )
    #end

    # Attempts to find the WordPress version from,
    # the generator tag in the Atom source.
    def find_from_atom_generator(target_uri, wp_content_dir, wp_plugins_dir)
      scan_url(
        target_uri,
        %r{<generator uri="http://wordpress.org/" version="#{version_pattern}">WordPress</generator>}i,
        'feed/atom/'
      )
    end

    # Attempts to find the WordPress version from,
    # the generator tag in the comment rss source.
    #
    # Have not been able to find an example of this - Ryan
    #def find_from_comments_rss_generator(target_uri, wp_content_dir, wp_plugins_dir)
    # scan_url(
    # target_uri,
    # %r{<!-- generator="WordPress/#{WpVersion.version_pattern}" -->}i,
    # 'comments/feed/'
    # )
    #end

    # Uses data/wp_versions.xml to try to identify a
    # wordpress version.
    #
    # It does this by using client side file hashing
    #
    # /!\ Warning : this method might return false positive if the file used for fingerprinting is part of a theme (they can be updated)
    #
    def find_from_advanced_fingerprinting(target_uri, wp_content_dir, wp_plugins_dir)
      xml     = xml(version_xml)
      # This wp_item will take care of encoding the path
      # and replace variables like $wp-content$ and $wp-plugins$
      wp_item = WpItem.new(target_uri,
                           wp_content_dir: wp_content_dir,
                           wp_plugins_dir: wp_plugins_dir)

      xml.xpath('//file').each do |node|
        wp_item.path = node.attribute('src').text

        response = Browser.instance.get(wp_item.url)
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
    def find_from_readme(target_uri, wp_content_dir, wp_plugins_dir)
      scan_url(
        target_uri,
        %r{<br />\sversion #{version_pattern}}i,
        'readme.html'
      )
    end

    # Attempts to find the WordPress version from the sitemap.xml file.
    #
    # See: http://code.google.com/p/wpscan/issues/detail?id=109
    def find_from_sitemap_generator(target_uri, wp_content_dir, wp_plugins_dir)
      scan_url(
        target_uri,
        %r{generator="wordpress/#{version_pattern}"}i,
        'sitemap.xml'
      )
    end

    # Attempts to find the WordPress version from the p-links-opml.php file.
    def find_from_links_opml(target_uri, wp_content_dir, wp_plugins_dir)
      scan_url(
        target_uri,
        %r{generator="wordpress/#{version_pattern}"}i,
        'wp-links-opml.php'
      )
    end

    # Used to check if the version is correct: must contain at least one dot.
    def version_pattern
      '([^\r\n"\']+\.[^\r\n"\']+)'
    end

  end
end
