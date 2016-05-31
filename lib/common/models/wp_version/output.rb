# encoding: UTF-8

class WpVersion < WpItem
  module Output

    def output(verbose = false)
      metadata = self.metadata(self.number)

      puts
      if verbose
        puts info("WordPress version #{self.number} identified from #{self.found_from}")
        puts " | Released: #{metadata[:release_date]}"
        puts " | Changelog: #{metadata[:changelog_url]}"
      else
        puts info("WordPress version #{self.number} #{"(Released on #{metadata[:release_date]}) identified from #{self.found_from}" if metadata[:release_date]}")
      end

      vulnerabilities = self.vulnerabilities

      unless vulnerabilities.empty?
        if vulnerabilities.size == 1
           puts critical("#{vulnerabilities.size} vulnerability identified from the version number")
        else
           puts critical("#{vulnerabilities.size} vulnerabilities identified from the version number")
        end
        vulnerabilities.output
      end
    end

  end
end
