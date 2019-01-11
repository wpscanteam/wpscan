describe WPScan::Finders::Themes::Base do
  subject(:themes) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://ex.lo/' }

  describe '#finders' do
    it 'contains the expected finders' do
      expect(themes.finders.map { |f| f.class.to_s.demodulize })
        .to eq %w[UrlsInHomepage KnownLocations]
    end
  end
end
