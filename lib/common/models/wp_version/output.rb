# encoding: UTF-8

class WpVersion < WpItem
  module Output

    def output(verbose = false)
      puts
      puts info("WordPress version #{self.number} identified from #{self.found_from}")

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
