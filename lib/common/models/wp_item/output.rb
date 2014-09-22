# encoding: UTF-8

class WpItem
  module Output

    # @return [ Void ]
    def output(verbose = false)
      puts
      puts "#{info('[+]')} Name: #{self}" #this will also output the version number if detected
      puts " |  Location: #{url}"
      #puts " | WordPress: #{wordpress_url}" if wordpress_org_item?
      puts " |  Readme: #{readme_url}" if has_readme?
      puts " |  Changelog: #{changelog_url}" if has_changelog?
      puts "#{warning('[!]')} Directory listing is enabled: #{url}" if has_directory_listing?
      puts "#{warning('[!]')} An error_log file has been found: #{error_log_url}" if has_error_log?

      additional_output(verbose) if respond_to?(:additional_output)

      if version.nil? && vulnerabilities.length > 0
        puts
        puts "#{warning('[+]')} We could not determine a version so all vulnerabilities are printed out"
      end

      vulnerabilities.output
    end
  end
end
