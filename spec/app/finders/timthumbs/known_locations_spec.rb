# frozen_string_literal: true

describe WPScan::Finders::Timthumbs::KnownLocations do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://ex.lo/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('timthumbs', 'known_locations') }

  describe '#aggressive' do
    let(:list_file) { fixtures.join('paths.txt') }
    let(:opts) { { list: list_file.to_s } }

    before do
      stub_request(:get, url).to_return(status: 200, body: '')
      stub_request(:head, url).to_return(status: 200)
      allow(target).to receive(:content_dir).and_return('wp-content')
      allow(target).to receive(:plugins_dir).and_return('wp-content/plugins')
      allow(target).to receive(:themes_dir).and_return('wp-content/themes')
      allow(target).to receive(:main_theme).and_return(nil)
      expect(target).to receive(:homepage_or_404?).at_least(:once).and_return(false)

      allow(target).to receive(:url).with(no_args).and_return(url)
      allow(target).to receive(:url).with('timthumb.php').and_return("#{url}timthumb.php")
      allow(target).to receive(:url).with('thumb.php').and_return("#{url}thumb.php")
      allow(target).to receive(:url).with('other.php').and_return("#{url}other.php")

      # Catch-all stubs for any plugin/theme URLs from previous tests
      stub_request(:any, %r{http://ex\.lo/wp-content/plugins/}).to_return(status: 404)
      stub_request(:any, %r{http://ex\.lo/wp-content/themes/}).to_return(status: 404)

      stub_request(:head, "#{url}timthumb.php").to_return(status: 400)
      stub_request(:get, "#{url}timthumb.php")
        .to_return(status: 400, body: 'no image specified')

      stub_request(:head, "#{url}thumb.php").to_return(status: 400)
      stub_request(:get, "#{url}thumb.php")
        .to_return(status: 400, body: 'different error')

      stub_request(:head, "#{url}other.php").to_return(status: 404)
      stub_request(:get, "#{url}other.php").to_return(status: 404)
    end

    it 'returns timthumb files with matching body' do
      timthumbs = finder.aggressive(opts)

      expect(timthumbs.size).to eq 1
      expect(timthumbs[0]).to be_a WPScan::Model::Timthumb
      expect(timthumbs[0].url).to eq "#{url}timthumb.php"
      expect(timthumbs[0].confidence).to eq 100
      expect(timthumbs[0].found_by).to match(/Known Locations/)
    end
  end
end
