# frozen_string_literal: true

describe WPScan::Finders::Medias::AttachmentBruteForcing do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://ex.lo/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('medias', 'attachment_brute_forcing') }

  describe '#aggressive' do
    let(:opts) { { range: (1..3) } }

    before do
      stub_request(:get, url).to_return(status: 200, body: '')
      stub_request(:head, url).to_return(status: 200)
      allow(target).to receive(:content_dir).and_return('wp-content')
      allow(target).to receive(:plugins_dir).and_return('wp-content/plugins')
      allow(target).to receive(:themes_dir).and_return('wp-content/themes')
      allow(target).to receive(:main_theme).and_return(nil)

      # Catch-all stubs for any plugin/theme URLs from previous tests
      stub_request(:any, %r{http://ex\.lo/wp-content/plugins/}).to_return(status: 404)
      stub_request(:any, %r{http://ex\.lo/wp-content/themes/}).to_return(status: 404)

      stub_request(:head, "#{url}?attachment_id=1").to_return(status: 200)
      stub_request(:get, "#{url}?attachment_id=1").to_return(status: 200, body: '')

      stub_request(:head, "#{url}?attachment_id=2").to_return(status: 200)
      stub_request(:get, "#{url}?attachment_id=2").to_return(status: 200, body: '')

      stub_request(:head, "#{url}?attachment_id=3").to_return(status: 404)
      stub_request(:get, "#{url}?attachment_id=3").to_return(status: 404, body: '')
    end

    it 'returns Media objects for valid attachment IDs' do
      medias = finder.aggressive(opts)

      expect(medias.size).to eq 2
      expect(medias[0]).to be_a WPScan::Model::Media
      expect(medias[0].url).to eq "#{url}?attachment_id=1"
      expect(medias[0].confidence).to eq 100
      expect(medias[0].found_by).to match(/Attachment Brute Forcing/)

      expect(medias[1].url).to eq "#{url}?attachment_id=2"
      expect(medias[1].confidence).to eq 100
    end
  end

  describe '#target_urls' do
    it 'returns the expected urls' do
      expect(finder.target_urls(range: (1..2))).to eql(
        "#{url}?attachment_id=1" => 1,
        "#{url}?attachment_id=2" => 2
      )
    end
  end
end
