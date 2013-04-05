# encoding: UTF-8

class Vulnerabilities < Array
  module Output

    def output
      self.each do |v|
        v.output
      end
    end

  end
end
