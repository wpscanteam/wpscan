describe WPScan::Finders::MainTheme::WooFrameworkMetaGenerator do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url).extend(CMSScanner::Target::Server::Apache) }
  let(:url)        { 'http://wp.lab/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('main_theme', 'woo_framework_meta_generator') }

  describe '#passive' do
    after do
      stub_request(:get, url).to_return(body: File.read(fixtures.join(@file)))

      expect(finder.passive).to eql @expected
    end

    context 'when no Woo generator' do
      it 'returns nil' do
        @file     = 'no_woo_generator.html'
        @expected = nil
      end
    end

    context 'when Woo generator' do
      before do
        expect(target).to receive(:content_dir).at_least(1).and_return('wp-content')
        stub_request(:get, "#{url}wp-content/themes/Merchant/style.css")
      end

      it 'returns the expected theme' do
        @file     = 'woo_generator.html'
        @expected = WPScan::Theme.new(
          'Merchant', target,
          found_by: 'Woo Framework Meta Generator (Passive Detection)',
          confidence: 80
        )
      end
    end
  end
end
