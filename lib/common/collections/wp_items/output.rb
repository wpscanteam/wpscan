# encoding: UTF-8

class WpItems < Array
  module Output

    def output
      self.each { |item| item.output }
    end

  end
end
