# frozen_string_literal: true

describe WPScan::Finders::WpVersion::UniqueFingerprinting do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url).extend(WPScan::Target::Server::Apache) }
  let(:url)        { 'http://ex.lo/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('wp_version', 'unique_fingerprinting') }

  describe '#aggressive' do
    let(:fingerprints) do
      {
        'wp-includes/css/dashicons.min.css' => {
          finder.hexdigest('dashicons_v4_0_body') => '4.0'
        }
      }
    end

    before do
      allow(WPScan::DB::Fingerprints).to receive(:wp_unique_fingerprints).and_return(fingerprints)
      allow(target).to receive(:sub_dir).and_return(false)
      allow(target).to receive(:homepage_or_404?).and_return(false)
      allow(target).to receive(:content_dir).and_return('wp-content')
      allow(target).to receive(:plugins_dir).and_return('wp-content/plugins')
      allow(target).to receive(:themes_dir).and_return('wp-content/themes')
      allow(target).to receive(:main_theme).and_return(nil)

      stub_request(:get, url).to_return(status: 200, body: '')
      stub_request(:head, url).to_return(status: 200)

      # Catch-all stubs for any plugin/theme URLs from previous tests
      stub_request(:any, %r{http://ex\.lo/wp-content/plugins/}).to_return(status: 404)
      stub_request(:any, %r{http://ex\.lo/wp-content/themes/}).to_return(status: 404)
    end

    context 'when no matches' do
      before do
        stub_request(:head, target.url('wp-includes/css/dashicons.min.css')).to_return(status: 404)
      end

      its(:aggressive) { should be nil }
    end

    context 'when a match is found' do
      before do
        stub_request(:head, target.url('wp-includes/css/dashicons.min.css')).to_return(status: 200)
        stub_request(:get, target.url('wp-includes/css/dashicons.min.css'))
          .to_return(status: 200, body: 'dashicons_v4_0_body')
      end

      it 'returns the expected WpVersion' do
        result = finder.aggressive

        expect(result).to be_a WPScan::Model::WpVersion
        expect(result.number).to eql '4.0'
        expect(result.confidence).to eql 100
        expect(result.found_by).to match(/Unique Fingerprinting/)
        expect(result.interesting_entries.first).to match(/dashicons\.min\.css/)
        expect(result.interesting_entries.first).to match(/md5sum is/)
      end
    end
  end
end
