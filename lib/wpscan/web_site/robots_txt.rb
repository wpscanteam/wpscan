# encoding: UTF-8

class WebSite
  module RobotsTxt

    # Checks if a robots.txt file exists
    # @return [ Boolean ]
    def has_robots?
      Browser.get(robots_url).code == 200
    end

    # Gets a robots.txt URL
    # @return [ String ]
    def robots_url
      @uri.clone.merge('robots.txt').to_s
    end

    # Parse robots.txt
    # @return [ Array ] URLs generated from robots.txt
    def parse_robots_txt
      return_object = []

      # Make request
      response = Browser.get(robots_url.to_s)
      body = response.body

      # Get all allow and disallow urls
      entries = body.scan(/^(?:dis)?allow:\s*(.*)$/i)

      # Did we get something?
      if entries
        # Remove any rubbish
        entries = clean_uri(entries)

        # Sort
        entries.sort!

        # Wordpress URL
        wordpress_path = @uri.path

        # Each "boring" value as defined below, remove
        RobotsTxt.known_dirs.each do |d|
          entries.delete(d)
          # Also delete when wordpress is installed in subdir
          dir_with_subdir = "#{wordpress_path}/#{d}".gsub(/\/+/, '/')
          entries.delete(dir_with_subdir)
        end

        # Convert to full URIs
        return_object = full_uri(entries)
      end
      return return_object
    end

    protected

    # Useful ~ "function do_robots()" -> https://github.com/WordPress/WordPress/blob/master/wp-includes/functions.php
    #
    # @return [ Array ]
    def self.known_dirs
      %w{
        /
        /wp-admin/
        /wp-admin/admin-ajax.php
        /wp-includes/
        /wp-content/
      }
    end
  end
end
