# frozen_string_literal: true

describe WPScan::Finders::Themes::WpJsonApi do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://wp.lab/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('themes', 'wp_json_api') }
  let(:api_url)    { 'http://wp.lab/wp-json/wp/v2/themes' }
  let(:userpwd)    { 'admin:app-password' }

  before do
    allow(target).to receive(:sub_dir).and_return(false)
    allow(target).to receive(:content_dir).and_return('wp-content')
    allow(target).to receive(:themes_dir).and_return('wp-content/themes')
    # Theme#initialize fetches style.css for parse_style; stub it so the spec
    # focuses on the WP JSON API behaviour.
    stub_request(:get, %r{http://wp\.lab/wp-content/themes/.*/style\.css}).to_return(body: '')
  end

  describe '#aggressive' do
    context 'when the endpoint returns 200 with JSON themes' do
      before do
        stub_request(:get, api_url)
          .to_return(status: 200, body: File.read(fixtures.join('themes.json')))
      end

      it 'returns Theme instances populated from the response' do
        themes = finder.aggressive(userpwd: userpwd)

        expect(themes.map(&:slug)).to eql %w[twentytwentyfour twentytwentythree]

        active = themes.first
        expect(active.confidence).to eql 100
        expect(active.found_by).to eql 'WP REST API (Authenticated)'
        expect(active.version.number).to eql '1.2'
        expect(active.instance_variable_get(:@wp_json_active)).to be true

        expect(themes.last.instance_variable_get(:@wp_json_active)).to be false
      end
    end

    context 'when the endpoint returns 401' do
      before { stub_request(:get, api_url).to_return(status: 401, body: '{}') }

      it 'raises WpAuthFailed' do
        expect { finder.aggressive(userpwd: userpwd) }.to raise_error(WPScan::Error::WpAuthFailed)
      end
    end

    context 'when the endpoint returns 500' do
      before { stub_request(:get, api_url).to_return(status: 500, body: '') }

      it 'raises WpAuthEndpointUnavailable' do
        expect { finder.aggressive(userpwd: userpwd) }.to raise_error(WPScan::Error::WpAuthEndpointUnavailable)
      end
    end
  end
end
