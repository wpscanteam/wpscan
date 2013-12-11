# encoding: UTF-8

class WpItems < Array
  module Output

    def output(verbose = false)
      self.each { |item| item.output(verbose) }
    end

  end
end
