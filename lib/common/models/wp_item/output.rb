# encoding: UTF-8

class WpItem
  module Output

    # @return [ Void ]
    def output(verbose = false)
      outdated = VersionCompare.lesser?(version, latest_version) if latest_version

      puts
      puts info("Name: #{self}") #this will also output the version number if detected
      puts " |  Latest version: #{latest_version} #{'(up to date)' if version}" if latest_version && !outdated
      puts " |  Last updated: #{last_updated}" if last_updated
      puts " |  Location: #{url}"
      puts " |  Readme: #{readme_url}" if has_readme?
      puts " |  Changelog: #{changelog_url}" if has_changelog?
      puts warning("The version is out of date, the latest version is #{latest_version}") if latest_version && outdated

      puts warning("Directory listing is enabled: #{url}") if has_directory_listing?
      puts warning("An error_log file has been found: #{error_log_url}") if has_error_log?

      additional_output(verbose) if respond_to?(:additional_output)

      if version.nil? && vulnerabilities.length > 0
        puts
        puts warning('We could not determine a version so all vulnerabilities are printed out')
      end

      vulnerabilities.output
    end
  end
end
