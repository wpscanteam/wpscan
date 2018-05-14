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

    # Check status code for each robots.txt entry
    def header_robots_txt(url)
      code = Browser.get(url).code
      puts info("Interesting entry from robots.txt: #{url}   [HTTP #{code}]")
    end

    # Parse robots.txt
    # @return [ Array ] URLs generated from robots.txt
    def parse_robots_txt
      return unless has_robots?

      return_object = []
      response = Browser.get(robots_url.to_s)
      body = response.body

      # Get all allow and disallow urls
      entries = body.scan(/^(?:dis)?allow:\s*(.*)$/i)
      if entries
        #extract elements
        entries.flatten!
        # Remove any leading/trailing spaces
        entries.collect{|x| x.strip || x }
        # End Of Line issues
        entries.collect{|x| x.chomp! || x }
        # Remove nil's and sort
        entries.compact.sort!
        # Unique values only
        entries.uniq!
        # Wordpress URL
        wordpress_path = @uri.path

        # Each "boring" value as defined below, remove
        RobotsTxt.known_dirs.each do |d|
          entries.delete(d)
          # Also delete when wordpress is installed in subdir
          dir_with_subdir = "#{wordpress_path}/#{d}".gsub(/\/+/, '/')
          entries.delete(dir_with_subdir)
        end

        # Each value now, try and make it a full URL
        entries.each do |d|
          begin
            temp = @uri.clone
            temp.path = d.strip
          rescue URI::Error
            temp = d.strip
          end
          return_object << temp.to_s
        end

      end
      return_object
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
