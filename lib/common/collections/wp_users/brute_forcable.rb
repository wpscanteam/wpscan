# encoding: UTF-8

class WpUsers < WpItems
  module BruteForcable

    # Brute force each wp_user
    #
    # To avoid loading the wordlist each time in the wp_user instance
    # It's loaded here, and given to the wp_user
    #
    # @param [ String, Array<String> ] wordlist
    # @param [ Hash ] options See WpUser::BruteForcable#brute_force
    #
    # @return [ void ]
    def brute_force(wordlist, options = {})
      passwords = WpUser::BruteForcable.passwords_from_wordlist(wordlist)

      self.each { |wp_user| wp_user.brute_force(passwords, options) }
    end

  end
end
