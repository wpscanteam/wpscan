# frozen_string_literal: true

describe WPScan::Finders::Timthumbs::Base do
  subject(:timthumb) { described_class.new(target) }
  let(:target)       { WPScan::Target.new(url) }
  let(:url)          { 'http://ex.lo/' }

  describe '#finders' do
    it 'contains the expected finders' do
      expect(timthumb.finders.map { |f| f.class.to_s.demodulize }).to eq %w[KnownLocations]
    end
  end
end
