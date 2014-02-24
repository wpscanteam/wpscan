# encoding: UTF-8

class WpTimthumb < WpItem
  module Output

    def output(verbose = false)
      puts " | #{vulnerable? ? red('[!] Vulnerable') : green('[i] Not Vulnerable')} #{self}"
    end

  end
end
