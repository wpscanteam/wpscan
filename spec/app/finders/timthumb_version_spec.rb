# frozen_string_literal: true

describe WPScan::Finders::TimthumbVersion::Base do
  subject(:timthumb_version) { described_class.new(target) }
  let(:target)               { WPScan::Model::Timthumb.new(url) }
  let(:url)                  { 'http://ex.lo/timthumb.php' }

  describe '#finders' do
    it 'contains the expected finders' do
      expect(timthumb_version.finders.map { |f| f.class.to_s.demodulize }).to eq %w[BadRequest]
    end
  end
end
