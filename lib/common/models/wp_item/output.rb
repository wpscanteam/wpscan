# encoding: UTF-8

class WpItem
  module Output

    # @return [ Void ]
    def output
      puts
      puts " | Name: #{self}" #this will also output the version number if detected
      puts " | Location: #{url}"
      #puts " | WordPress: #{wordpress_url}" if wordpress_org_item?
      puts ' | Directory listing enabled: Yes' if has_directory_listing?
      puts " | Readme: #{readme_url}" if has_readme?
      puts " | Changelog: #{changelog_url}" if has_changelog?

      vulnerabilities.output

      if has_error_log?
        puts ' | ' + red('[!]') + " An error_log file has been found : #{error_log_url}"
      end
    end

  end
end
