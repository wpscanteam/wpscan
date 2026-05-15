# frozen_string_literal: true

describe WPScan::Finders::InterestingFindings::Multisite do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url).extend(WPScan::Target::Server::Apache) }
  let(:url)        { 'http://ex.lo/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('interesting_findings', 'multisite') }

  describe '#aggressive' do
    let(:signup_url) { 'http://ex.lo/wp-signup.php' }

    before do
      allow(target).to receive(:sub_dir).and_return(false)
      stub_request(:get, signup_url).to_return(status: status_code, headers: headers)
    end

    context 'when wp-signup.php returns 404' do
      let(:status_code) { 404 }
      let(:headers) { {} }

      it 'returns nil' do
        expect(finder.aggressive).to be nil
      end
    end

    context 'when wp-signup.php returns 200' do
      let(:status_code) { 200 }
      let(:headers) { {} }

      it 'returns Multisite finding' do
        result = finder.aggressive

        expect(result).to be_a WPScan::Model::Multisite
        expect(result.url).to eq signup_url
        expect(result.confidence).to eq 100
        expect(result.found_by).to eq 'Direct Access (Aggressive Detection)'
      end

      it 'sets target.multisite to true' do
        expect { finder.aggressive }.to change { target.multisite }.from(nil).to(true)
      end
    end

    context 'when wp-signup.php returns 302 to wp-login.php?action=register' do
      let(:status_code) { 302 }
      let(:headers) { { 'location' => 'http://ex.lo/wp-login.php?action=register' } }

      it 'returns nil (not a multisite)' do
        expect(finder.aggressive).to be nil
      end
    end

    context 'when wp-signup.php returns 302 to wp-signup.php' do
      let(:status_code) { 302 }
      let(:headers) { { 'location' => 'http://ex.lo/wp-signup.php?foo=bar' } }

      it 'returns Multisite finding' do
        result = finder.aggressive

        expect(result).to be_a WPScan::Model::Multisite
        expect(result.url).to eq signup_url
        expect(result.confidence).to eq 100
      end

      it 'sets target.multisite to true' do
        expect { finder.aggressive }.to change { target.multisite }.from(nil).to(true)
      end
    end

    context 'when wp-signup.php returns 302 with no location header' do
      let(:status_code) { 302 }
      let(:headers) { {} }

      it 'returns nil' do
        expect(finder.aggressive).to be nil
      end
    end

    context 'when wp-signup.php returns 500' do
      let(:status_code) { 500 }
      let(:headers) { {} }

      it 'returns nil' do
        expect(finder.aggressive).to be nil
      end
    end
  end
end
