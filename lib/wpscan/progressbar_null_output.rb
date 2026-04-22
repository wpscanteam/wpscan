# frozen_string_literal: true

require 'ruby-progressbar/outputs/null'

module WPScan
  # Adds the feature to log message sent to #log
  # So they can be retrieved at some point, like after a password attack with a JSON output
  # which won't display the progressbar but still call #log for errors etc
  class ProgressBarNullOutput < ::ProgressBar::Outputs::Null
    # @retutn [ Array<String> ]
    def logs
      @logs ||= []
    end

    # Override of parent method
    # @return [ Array<String> ] return the logs when no string provided
    def log(string = nil)
      return logs if string.nil?

      logs << string unless logs.include?(string)
    end
  end
end
