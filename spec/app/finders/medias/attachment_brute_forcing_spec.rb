# frozen_string_literal: true

describe WPScan::Finders::Medias::AttachmentBruteForcing do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://ex.lo/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('medias', 'attachment_brute_forcing') }

  describe '#aggressive' do
    xit
  end

  describe '#target_urls' do
    it 'returns the expected urls' do
      expect(finder.target_urls(range: (1..2))).to eql(
        url + '?attachment_id=1' => 1,
        url + '?attachment_id=2' => 2
      )
    end
  end
end
