# frozen_string_literal: true

describe WPScan::Finders::Plugins::WpJsonApi do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://wp.lab/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('plugins', 'wp_json_api') }
  let(:api_url)    { 'http://wp.lab/wp-json/wp/v2/plugins' }
  let(:userpwd)    { 'admin:app-password' }

  before do
    allow(target).to receive(:sub_dir).and_return(false)
    allow(target).to receive(:content_dir).and_return('wp-content')
    allow(target).to receive(:plugins_dir).and_return('wp-content/plugins')
  end

  describe '#api_url' do
    its(:api_url) { should eql api_url }
  end

  describe '#aggressive' do
    context 'when the endpoint returns 200 with JSON plugins' do
      before do
        stub_request(:get, api_url)
          .to_return(status: 200, body: File.read(fixtures.join('plugins.json')))
      end

      it 'returns Plugin instances populated from the response' do
        plugins = finder.aggressive(userpwd: userpwd)

        expect(plugins.map(&:slug)).to eql %w[akismet wordfence hello no-version-plugin]

        akismet = plugins.first
        expect(akismet.confidence).to eql 100
        expect(akismet.found_by).to eql 'WP REST API (Authenticated)'
        expect(akismet.interesting_entries).to eql [api_url]
        expect(akismet.version.number).to eql '5.3'
        expect(akismet.version.confidence).to eql 100
      end

      it 'leaves version as false when the API has no version' do
        plugins = finder.aggressive(userpwd: userpwd)
        expect(plugins.last.version).to be false
      end
    end

    context 'when the endpoint returns 401' do
      before { stub_request(:get, api_url).to_return(status: 401, body: '{}') }

      it 'raises WpAuthFailed' do
        expect { finder.aggressive(userpwd: userpwd) }.to raise_error(WPScan::Error::WpAuthFailed)
      end
    end

    context 'when the endpoint returns 403' do
      before { stub_request(:get, api_url).to_return(status: 403, body: '{}') }

      it 'raises WpAuthFailed' do
        expect { finder.aggressive(userpwd: userpwd) }.to raise_error(WPScan::Error::WpAuthFailed)
      end
    end

    context 'when the endpoint returns 404' do
      before { stub_request(:get, api_url).to_return(status: 404, body: '') }

      it 'raises WpAuthEndpointUnavailable' do
        expect { finder.aggressive(userpwd: userpwd) }.to raise_error(WPScan::Error::WpAuthEndpointUnavailable)
      end
    end

    context 'when the body is malformed JSON' do
      before { stub_request(:get, api_url).to_return(status: 200, body: '<html>not json</html>') }

      its(:aggressive) { should eql [] }
    end
  end
end
