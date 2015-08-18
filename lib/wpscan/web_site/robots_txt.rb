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
      return unless has_robots?

      return_object = []
      response = Browser.get(robots_url.to_s)
      body = response.body
      # Get all allow and disallow urls
      entries = body.scan(/^(?:dis)?allow:\s*(.*)$/i)
      if entries
        entries.flatten!
        entries.compact.sort!
        entries.uniq!
        wordpress_path = @uri.path
        RobotsTxt.known_dirs.each do |d|
          entries.delete(d)
          # also delete when wordpress is installed in subdir
          dir_with_subdir = "#{wordpress_path}/#{d}".gsub(/\/+/, '/')
          entries.delete(dir_with_subdir)
        end

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

    # @return [ Array ]
    def self.known_dirs
      %w{
        /
        /wp-admin/
        /wp-includes/
        /wp-content/
      }
    end

  end
end
