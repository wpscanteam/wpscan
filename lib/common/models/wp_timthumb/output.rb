# encoding: UTF-8

class WpTimthumb < WpItem
  module Output

    def output(verbose = false)
      puts ' | ' + red('[!]') + " #{self}"
    end

  end
end
