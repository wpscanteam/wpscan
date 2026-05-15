# frozen_string_literal: true

describe WPScan::Finders::InterestingFindings::Registration do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url).extend(WPScan::Target::Server::Apache) }
  let(:url)        { 'http://ex.lo/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('interesting_findings', 'registration') }

  describe '#aggressive' do
    let(:register_url) { 'http://ex.lo/wp-login.php?action=register' }

    before do
      allow(target).to receive(:registration_url).and_return(register_url)
      stub_request(:get, register_url).to_return(status: status_code, body: body)
    end

    context 'when registration page returns 404' do
      let(:status_code) { 404 }
      let(:body) { '' }

      it 'returns nil' do
        expect(finder.aggressive).to be nil
      end
    end

    context 'when registration page returns 200 but no registration forms' do
      let(:status_code) { 200 }
      let(:body) { '<html><body><p>No forms here</p></body></html>' }

      it 'returns nil' do
        expect(finder.aggressive).to be nil
      end
    end

    context 'when registration page returns 200 with setupform' do
      let(:status_code) { 200 }
      let(:body) { '<html><body><form id="setupform"><input type="text"/></form></body></html>' }

      it 'returns Registration finding' do
        result = finder.aggressive

        expect(result).to be_a WPScan::Model::Registration
        expect(result.url).to eq register_url
        expect(result.confidence).to eq 100
        expect(result.found_by).to eq 'Direct Access (Aggressive Detection)'
      end

      it 'sets target.registration_enabled to true' do
        expect { finder.aggressive }.to change { target.registration_enabled }.from(nil).to(true)
      end
    end

    context 'when registration page returns 200 with registerform' do
      let(:status_code) { 200 }
      let(:body) { '<html><body><form id="registerform"><input type="text"/></form></body></html>' }

      it 'returns Registration finding' do
        result = finder.aggressive

        expect(result).to be_a WPScan::Model::Registration
        expect(result.url).to eq register_url
        expect(result.confidence).to eq 100
      end

      it 'sets target.registration_enabled to true' do
        expect { finder.aggressive }.to change { target.registration_enabled }.from(nil).to(true)
      end
    end

    context 'when registration page returns 200 with both forms' do
      let(:status_code) { 200 }
      let(:body) { '<html><body><form id="setupform"></form><form id="registerform"></form></body></html>' }

      it 'returns Registration finding' do
        result = finder.aggressive
        expect(result).to be_a WPScan::Model::Registration
      end
    end
  end
end
