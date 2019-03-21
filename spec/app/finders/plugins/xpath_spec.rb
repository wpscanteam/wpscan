# frozen_string_literal: true

describe WPScan::Finders::Plugins::Xpath do
  it_behaves_like WPScan::Finders::DynamicFinder::WpItems::Finder do
    subject(:finder)   { described_class.new(target) }
    let(:target)       { WPScan::Target.new(url) }
    let(:url)          { 'http://wp.lab/' }
    let(:fixtures)     { DYNAMIC_FINDERS_FIXTURES.join('plugin_version') }

    let(:expected_all) { df_expected_all['plugins'] }
    let(:item_class)   { WPScan::Model::Plugin }
  end
end
