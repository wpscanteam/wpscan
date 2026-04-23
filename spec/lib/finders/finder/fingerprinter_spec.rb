# frozen_string_literal: true

describe WPScan::Finders::Finder::Fingerprinter do
  # Dummy class to test the module
  class DummyFingerprinterFinder < WPScan::Finders::Finder
    include WPScan::Finders::Finder::Fingerprinter
  end

  subject(:finder) { DummyFingerprinterFinder.new(target) }
  let(:target)     { WPScan::Target.new('http://e.org/') }

  describe '#fingerprint' do
    let(:fingerprints) do
      {
        'f1.css' => {
          finder.hexdigest('f1_body') => 'v1'
        },
        'f2.js' => {
          finder.hexdigest('f2_body') => %w[v1 v2],
          finder.hexdigest('f2_2_body') => %w[v3]
        }
      }
    end

    before do
      stub_request(:get, /e\.org/)
      expect(target).to receive(:head_or_get_params).and_return(method: :head)
    end

    context 'when no matches' do
      before { stub_request(:head, /.*/).to_return(status: 404) }

      it 'does not yield anything' do
        expect { |b| finder.fingerprint(fingerprints, &b) }.not_to yield_control
      end
    end

    context 'when matches' do
      before do
        stub_request(:get, /.*/).to_return(body: '404 body')

        stub_request(:head, target.url('f1.css'))
        stub_request(:get, target.url('f1.css')).to_return(body: 'f1_body')

        stub_request(:head, target.url('f2.js'))
        stub_request(:get, target.url('f2.js')).to_return(body: 'f2_body')
      end

      it 'yields the expected arguments' do
        expect { |b| finder.fingerprint(fingerprints, &b) }.to yield_successive_args(
          ['v1', target.url('f1.css'), finder.hexdigest('f1_body')],
          [%w[v1 v2], target.url('f2.js'), finder.hexdigest('f2_body')]
        )
      end
    end
  end
end
