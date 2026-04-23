# frozen_string_literal: true

module WPScan
  module Finders
    # Dummy Class to test the module
    class PluginsFinderSpec
      include SameTypeFinder

      def initialize(_target); end
    end
  end
end

describe WPScan::Finders::PluginsFinderSpec do
  it_behaves_like WPScan::Finders::IndependentFinder do
    let(:expected_finders) { [] }
    let(:expected_finders_class) { WPScan::Finders::SameTypeFinders }
  end

  subject(:plugins) { described_class.new(target) }
  let(:target)      { WPScan::Target.new(url) }
  let(:url)         { 'http://example.com/' }
end
