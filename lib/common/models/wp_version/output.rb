# encoding: UTF-8

class WpVersion < WpItem
  module Output

    def output
      puts green('[+]') + " WordPress version #{self.number} identified from #{self.found_from}"

      vulnerabilities = self.vulnerabilities

      unless vulnerabilities.empty?
        puts
        puts red('[!]') + " We have identified #{vulnerabilities.size} vulnerabilities from the version number :"

        vulnerabilities.output
      end
    end

  end
end
