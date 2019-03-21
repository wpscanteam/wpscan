# frozen_string_literal: true

describe WPScan::Finders::DbExports::Base do
  subject(:db_exports) { described_class.new(target) }
  let(:target)         { WPScan::Target.new(url) }
  let(:url)            { 'http://ex.lo/' }

  describe '#finders' do
    it 'contains the expected finders' do
      expect(db_exports.finders.map { |f| f.class.to_s.demodulize }).to eq %w[KnownLocations]
    end
  end
end
