# frozen_string_literal: true

module WPScan
  # Needed to load at least the Core controller
  # Otherwise, the following error will be raised:
  # `initialize': uninitialized constant WPScan::Controller::Core (NameError)
  module Controller
    include CMSScanner::Controller
  end
end
