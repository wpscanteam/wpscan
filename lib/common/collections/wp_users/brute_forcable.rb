# encoding: UTF-8

class WpUsers < WpItems
  module BruteForcable

    def brute_force(wordlist, options = {})
      self.each { |wp_user| wp_user.brute_force(wordlist, options) }
    end

  end
end
