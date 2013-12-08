# encoding: UTF-8

class Vulnerabilities < Array
  module Output

    def output(verbose = false)
      self.each do |v|
        v.output(verbose)
      end
    end

  end
end
