# encoding: UTF-8

class WpUsers < WpItems
  module Detectable

    def request_params; {} end

    # options:
    #   :range - default 1..10
    def targets_items(wp_target, options = {})
      range   = options[:range] || (1..10)
      targets = []

      range.each do |user_id|
        targets << WpUser.new(wp_target.uri, id: user_id)
      end
      targets
    end

    # No passive detection
    # @return [ WpUsers ]
    def passive_detection(wp_target, options = {})
      new
    end

  end
end
