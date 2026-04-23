# frozen_string_literal: true

module WPScan
  module Finders
    # Dummy Class to test the module
    class VersionFinderSpec
      include UniqueFinder

      def initialize(_target); end
    end
  end
end

describe WPScan::Finders::VersionFinderSpec do
  it_behaves_like WPScan::Finders::IndependentFinder do
    let(:expected_finders) { [] }
    let(:expected_finders_class) { WPScan::Finders::UniqueFinders }
  end

  subject(:version) { described_class.new(target) }
  let(:target)      { WPScan::Target.new(url) }
  let(:url)         { 'http://example.com/' }
end
