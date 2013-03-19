# encoding: UTF-8

class WpTimthumb < WpItem
  module Output

    def output
      puts ' | ' + red('[!]') + " #{self}"
    end

  end
end
