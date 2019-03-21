# frozen_string_literal: true

describe WPScan::Finders::ThemeVersion::WooFrameworkMetaGenerator do
  subject(:finder) { described_class.new(theme) }
  let(:theme)      { WPScan::Model::Theme.new(slug, target) }
  let(:target)     { WPScan::Target.new('http://wp.lab/') }
  let(:fixtures)   { FINDERS_FIXTURES.join('theme_version', 'woo_framework_meta_generator') }

  before do
    expect(target).to receive(:content_dir).and_return('wp-content')
    stub_request(:get, /\.css\z/)
  end

  describe '#passive' do
    after do
      stub_request(:get, target.url).to_return(body: File.read(fixtures.join('editorial-1.3.5.html')))

      expect(finder.passive).to eql @expected
    end

    context 'when the theme slug does not match' do
      let(:slug) { 'spec' }

      it 'returns nil' do
        @expected = nil
      end
    end

    context 'when the theme slug matches' do
      let(:slug) { 'Editorial' }

      it 'return the expected version' do
        @expected = WPScan::Model::Version.new(
          '1.3.5',
          found_by: 'Woo Framework Meta Generator (Passive Detection)',
          confidence: 80
        )
      end
    end
  end
end
