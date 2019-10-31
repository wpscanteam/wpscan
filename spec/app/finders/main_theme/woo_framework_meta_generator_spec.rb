# frozen_string_literal: true

describe WPScan::Finders::MainTheme::WooFrameworkMetaGenerator do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url).extend(CMSScanner::Target::Server::Apache) }
  let(:url)        { 'http://wp.lab/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('main_theme', 'woo_framework_meta_generator') }

  describe '#passive' do
    before do
      stub_request(:get, url).to_return(body: File.read(fixtures.join(homepage_fixture)))
      stub_request(:get, ERROR_404_URL_PATTERN).to_return(body: File.read(fixtures.join(error_404_fixture)))
    end

    context 'when no Woo generator' do
      let(:homepage_fixture) { 'no_woo_generator.html' }
      let(:error_404_fixture) { 'no_woo_generator.html' }

      it 'returns nil' do
        expect(finder.passive).to eql nil
      end
    end

    context 'when Woo generator' do
      before do
        allow(target).to receive(:content_dir).and_return('wp-content')
        stub_request(:get, "#{url}wp-content/themes/Merchant/style.css")
      end

      context 'from the homepage' do
        let(:homepage_fixture) { 'woo_generator.html' }
        let(:error_404_fixture) { 'no_woo_generator.html' }

        it 'returns the expected theme' do
          expect(finder.passive).to eql WPScan::Model::Theme.new(
            'Merchant', target,
            found_by: 'Woo Framework Meta Generator (Passive Detection)',
            confidence: 80
          )
        end
      end

      context 'from the 404 page' do
        let(:homepage_fixture) { 'no_woo_generator.html' }
        let(:error_404_fixture) { 'woo_generator.html' }

        it 'returns the expected theme' do
          expect(finder.passive).to eql WPScan::Model::Theme.new(
            'Merchant', target,
            found_by: 'Woo Framework Meta Generator (Passive Detection)',
            confidence: 80
          )
        end
      end
    end
  end
end
