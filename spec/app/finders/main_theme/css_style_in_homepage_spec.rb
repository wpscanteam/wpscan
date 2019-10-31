# frozen_string_literal: true

describe WPScan::Finders::MainTheme::CssStyleInHomepage do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url).extend(CMSScanner::Target::Server::Apache) }
  let(:url)        { 'http://wp.lab/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('main_theme', 'css_style_in_homepage') }

  describe '#passive' do
    after do
      stub_request(:get, url).to_return(body: File.read(fixtures.join(fixture)))
      expect(finder.passive).to eql @expected
    end

    context 'when no in scope style' do
      let(:fixture) { 'no_in_scope_style.html' }

      it 'returns nil' do
        @expected = nil
      end
    end

    context 'when in scope style' do
      before do
        expect(target).to receive(:content_dir).at_least(1).and_return('wp-content')
        stub_request(:get, /.*.css/)
      end

      context 'when in a link href' do
        let(:fixture) { 'link_href.html' }

        it 'returns the expected theme' do
          @expected = WPScan::Model::Theme.new(
            'twentyfifteen',
            target,
            found_by: 'Css Style In Homepage (Passive Detection)',
            confidence: 70,
            style_url: 'http://wp.lab/wp-content/themes/twentyfifteen/style.css?ver=4.1.1'
          )
        end
      end

      context 'when in the style code' do
        let(:fixture) { 'style_code.html' }

        it 'returns the expected theme' do
          @expected = WPScan::Model::Theme.new(
            'custom',
            target,
            found_by: 'Css Style In Homepage (Passive Detection)',
            confidence: 70,
            style_url: 'http://wp.lab/wp-content/themes/custom/style.css'
          )
        end
      end
    end
  end
end
