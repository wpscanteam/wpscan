# encoding: UTF-8

class WpUsers < WpItems
  module Detectable

    # @return [ Hash ]
    def request_params; {} end

    # No passive detection
    #
    # @return [ WpUsers ]
    def passive_detection(wp_target, options = {})
      new
    end

    protected

    # @param [ WpTarget ] wp_target
    # @param [ Hash ] options
    # @option options [ Range ] :range ((1..10))
    #
    # @return [ Array<WpUser> ]
    def targets_items(wp_target, options = {})
      range   = options[:range] || (1..10)
      targets = []

      range.each do |user_id|
        targets << WpUser.new(wp_target.uri, id: user_id)
      end
      targets
    end

  end
end
