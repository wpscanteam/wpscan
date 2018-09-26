module WPScan
  # Custom class to include the WPScan::References module
  class InterestingFinding < CMSScanner::InterestingFinding
    include References
  end
end
