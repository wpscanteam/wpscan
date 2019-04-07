# frozen_string_literal: true

module WPScan
  # To be able to use ParsedCli directly, rather than having to access it via WPscan::ParsedCli
  class ParsedCli < CMSScanner::ParsedCli
  end
end
