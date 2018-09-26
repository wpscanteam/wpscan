require 'spec_helper'

describe WPScan::Finders::Plugins::Comment do
  it_behaves_like WPScan::Finders::DynamicFinder::WpItems::Finder do
    subject(:finder) { described_class.new(target) }
    let(:target)     { WPScan::Target.new(url) }
    let(:url)        { 'http://wp.lab/' }
    let(:fixtures)   { File.join(DYNAMIC_FINDERS_FIXTURES, 'plugin_version') }

    let(:expected_all) { df_expected_all['plugins'] }
    let(:item_class)   { WPScan::Plugin }
  end
end
