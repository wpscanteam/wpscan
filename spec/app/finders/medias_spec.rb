# frozen_string_literal: true

describe WPScan::Finders::Medias::Base do
  subject(:media) { described_class.new(target) }
  let(:target)    { WPScan::Target.new(url) }
  let(:url)       { 'http://ex.lo/' }

  describe '#finders' do
    it 'contains the expected finders' do
      expect(media.finders.map { |f| f.class.to_s.demodulize }).to eq %w[AttachmentBruteForcing]
    end
  end
end
