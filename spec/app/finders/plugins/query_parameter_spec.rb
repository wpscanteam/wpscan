# frozen_string_literal: true

describe WPScan::Finders::Plugins::QueryParameter do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://wp.lab/' }
  let(:fixtures)   { DYNAMIC_FINDERS_FIXTURES.join('plugin_version') }

  describe '#passive' do
    its(:passive) { should be nil }
  end

  describe '#aggressive' do
    xit
  end
end
