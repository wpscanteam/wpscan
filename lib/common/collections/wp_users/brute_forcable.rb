# encoding: UTF-8

class WpUsers < WpItems
  module BruteForcable

    # Brute force each wp_user
    #
    # @param [ String ] wordlist The path to the wordlist
    # @param [ Hash ] options See WpUser::BruteForcable#brute_force
    #
    # @return [ void ]
    def brute_force(wordlist, options = {})
      self.each { |wp_user| wp_user.brute_force(wordlist, options) }
    end

  end
end
