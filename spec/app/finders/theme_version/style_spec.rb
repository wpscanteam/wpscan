# frozen_string_literal: true

describe WPScan::Finders::ThemeVersion::Style do
  subject(:finder) { described_class.new(theme) }
  let(:theme)      { WPScan::Model::Theme.new('spec', target) }
  let(:target)     { WPScan::Target.new('http://wp.lab/') }
  let(:fixtures)   { FINDERS_FIXTURES.join('theme_version', 'style') }

  before :all do
    Typhoeus::Config.cache = WPScan::Cache::Typhoeus.new(SPECS.join('cache'))
  end

  before do
    expect(target).to receive(:content_dir).at_least(1).and_return('wp-content')
    stub_request(:get, /.*.css/).and_return(body: defined?(style_body) ? style_body : '')
  end

  describe '#passive' do
    before { expect(finder).to receive(:cached_style?).and_return(cached?) }
    after  { finder.passive }

    context 'when the style_url request has been cached' do
      let(:cached?) { true }

      it 'calls the style_version' do
        expect(finder).to receive(:style_version)
      end
    end

    context 'when the style_url request has not been cached' do
      let(:cached?) { false }

      it 'returns nil' do
        expect(finder).to_not receive(:style_version)
      end
    end
  end

  describe '#aggressive' do
    before { expect(finder).to receive(:cached_style?).and_return(cached?) }
    after  { finder.aggressive }

    context 'when the style_url request has been cached' do
      let(:cached?) { true }

      it 'returns nil' do
        expect(finder).to_not receive(:style_version)
      end
    end

    context 'when the style_url request has not been cached' do
      let(:cached?) { false }

      it 'calls the style_version' do
        expect(finder).to receive(:style_version)
      end
    end
  end

  describe '#cached_style?' do
    it 'calls the Cache with the correct arguments' do
      expected = Typhoeus::Request.new(
        theme.style_url,
        finder.browser.default_request_params.merge(method: :get)
      )

      expect(Typhoeus::Config.cache).to receive(:get) { |arg| expect(arg).to eql expected }
      finder.cached_style?
    end
  end

  describe '#style_version' do
    {
      'inline' => '1.5.1',
      'firefart' => '1.0.0',
      'tralling_quote' => '1.3',
      'no_version_tag' => nil,
      'trunk_version' => nil,
      'no_version' => nil
    }.each do |file, expected_version|
      context "when #{file}" do
        let(:style_body) { File.new(fixtures.join("#{file}.css")) }

        it 'returns the expected version' do
          expected = if expected_version
                       WPScan::Model::Version.new(
                         expected_version,
                         confidence: 80,
                         interesting_entries: ["#{theme.style_url}, Version: #{expected_version}"]
                       )
                     end

          expect(finder.style_version).to eql expected
        end
      end
    end
  end
end
