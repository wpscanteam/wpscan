# frozen_string_literal: true

describe WPScan::Finders::Themes::KnownLocations do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://ex.lo/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('themes', 'known_locations') }

  describe '#aggressive' do
    let(:opts) { { list: %w[theme1 theme2 theme3], threshold: 0 } }

    before do
      stub_request(:get, url).to_return(status: 200, body: '')
      stub_request(:head, url).to_return(status: 200)
      allow(target).to receive(:content_dir).and_return('wp-content')
      allow(target).to receive(:plugins_dir).and_return('wp-content/plugins')
      allow(target).to receive(:themes_dir).and_return('wp-content/themes')
      allow(target).to receive(:main_theme).and_return(nil)
      expect(target).to receive(:homepage_or_404?).at_least(:once).and_return(false)

      # Catch-all stubs for any plugin/theme URLs from previous tests
      stub_request(:any, %r{http://ex\.lo/wp-content/plugins/}).to_return(status: 404)
      stub_request(:any, %r{http://ex\.lo/wp-content/themes/}).to_return(status: 404)

      # Specific theme URL mocks and stubs for this test
      allow(target).to receive(:theme_url).with('theme1').and_return("#{url}wp-content/themes/theme1/")
      allow(target).to receive(:theme_url).with('theme2').and_return("#{url}wp-content/themes/theme2/")
      allow(target).to receive(:theme_url).with('theme3').and_return("#{url}wp-content/themes/theme3/")

      # These specific stubs override the catch-all above
      stub_request(:head, "#{url}wp-content/themes/theme1/").to_return(status: 200)
      stub_request(:get, "#{url}wp-content/themes/theme1/").to_return(status: 200, body: '')
      stub_request(:get, "#{url}wp-content/themes/theme1/style.css").to_return(status: 200, body: '')

      stub_request(:head, "#{url}wp-content/themes/theme2/").to_return(status: 403)
      stub_request(:get, "#{url}wp-content/themes/theme2/").to_return(status: 403, body: '')
      stub_request(:get, "#{url}wp-content/themes/theme2/style.css").to_return(status: 200, body: '')

      stub_request(:head, "#{url}wp-content/themes/theme3/").to_return(status: 404)
      stub_request(:get, "#{url}wp-content/themes/theme3/").to_return(status: 404, body: '')
    end

    it 'returns detected themes for valid response codes' do
      themes = finder.aggressive(opts)

      expect(themes.size).to eq 2
      expect(themes[0]).to be_a WPScan::Model::Theme
      expect(themes[0].slug).to eq 'theme1'
      expect(themes[0].confidence).to eq 80
      expect(themes[0].found_by).to match(/Known Locations/)

      expect(themes[1].slug).to eq 'theme2'
      expect(themes[1].confidence).to eq 80
    end

    context 'when threshold is reached' do
      let(:opts) { super().merge(threshold: 1) }

      it 'stops after threshold' do
        expect { finder.aggressive(opts) }.to raise_error(WPScan::Error::ThemesThresholdReached)
      end
    end
  end
end
