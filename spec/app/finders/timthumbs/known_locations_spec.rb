require 'spec_helper'

describe WPScan::Finders::Timthumbs::KnownLocations do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://ex.lo/' }
  let(:fixtures)   { File.join(FINDERS_FIXTURES, 'timthumbs', 'known_locations') }

  describe '#aggressive' do
    xit
  end
end
