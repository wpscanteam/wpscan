describe WPScan::Finders::Plugins::KnownLocations do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://ex.lo/' }
  let(:fixtures)   { File.join(FINDERS_FIXTURES, 'plugins', 'known_locations') }

  describe '#aggressive' do
    xit
  end
end
