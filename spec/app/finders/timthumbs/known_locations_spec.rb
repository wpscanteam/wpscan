# frozen_string_literal: true

describe WPScan::Finders::Timthumbs::KnownLocations do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://ex.lo/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('timthumbs', 'known_locations') }

  describe '#aggressive' do
    xit
  end
end
