# frozen_string_literal: true

describe WPScan::Finders::Plugins::KnownLocations do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://ex.lo/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('plugins', 'known_locations') }

  describe '#aggressive' do
    let(:opts) { { list: %w[plugin1 plugin2 plugin3], threshold: 0 } }

    before do
      stub_request(:get, url).to_return(status: 200, body: '')
      stub_request(:head, url).to_return(status: 200)
      allow(target).to receive(:content_dir).and_return('wp-content')
      allow(target).to receive(:plugins_dir).and_return('wp-content/plugins')
      expect(target).to receive(:homepage_or_404?).at_least(:once).and_return(false)

      allow(target).to receive(:plugin_url).with('plugin1').and_return("#{url}wp-content/plugins/plugin1/")
      allow(target).to receive(:plugin_url).with('plugin2').and_return("#{url}wp-content/plugins/plugin2/")
      allow(target).to receive(:plugin_url).with('plugin3').and_return("#{url}wp-content/plugins/plugin3/")

      stub_request(:head, "#{url}wp-content/plugins/plugin1/").to_return(status: 200)
      stub_request(:get, "#{url}wp-content/plugins/plugin1/").to_return(status: 200, body: '')

      stub_request(:head, "#{url}wp-content/plugins/plugin2/").to_return(status: 403)
      stub_request(:get, "#{url}wp-content/plugins/plugin2/").to_return(status: 403, body: '')

      stub_request(:head, "#{url}wp-content/plugins/plugin3/").to_return(status: 404)
      stub_request(:get, "#{url}wp-content/plugins/plugin3/").to_return(status: 404, body: '')
    end

    it 'returns detected plugins for valid response codes' do
      plugins = finder.aggressive(opts)

      expect(plugins.size).to eq 2
      expect(plugins[0]).to be_a WPScan::Model::Plugin
      expect(plugins[0].slug).to eq 'plugin1'
      expect(plugins[0].confidence).to eq 80
      expect(plugins[0].found_by).to match(/Known Locations/)

      expect(plugins[1].slug).to eq 'plugin2'
      expect(plugins[1].confidence).to eq 80
    end

    context 'when threshold is reached' do
      let(:opts) { super().merge(threshold: 1) }

      it 'stops after threshold' do
        expect { finder.aggressive(opts) }.to raise_error(WPScan::Error::PluginsThresholdReached)
      end
    end
  end
end
