# frozen_string_literal: true

describe WPScan::Finders::InterestingFindings::TmmDbMigrate do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url).extend(WPScan::Target::Server::Apache) }
  let(:url)        { 'http://ex.lo/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('interesting_findings', 'tmm_db_migrate') }

  describe '#aggressive' do
    let(:zip_url) { 'http://ex.lo/wp-content/uploads/tmm_db_migrate/tmm_db_migrate.zip' }

    before do
      allow(target).to receive(:sub_dir).and_return(false)
      allow(target).to receive(:content_dir).and_return('wp-content')
      expect(target).to receive(:head_or_get_request_params).and_return(method: :head)
      stub_request(:head, zip_url).to_return(status: status_code, headers: headers)
    end

    context 'when file returns 404' do
      let(:status_code) { 404 }
      let(:headers) { {} }

      it 'returns nil' do
        expect(finder.aggressive).to be nil
      end
    end

    context 'when file returns 200 but wrong Content-Type' do
      let(:status_code) { 200 }
      let(:headers) { { 'Content-Type' => 'text/html' } }

      it 'returns nil' do
        expect(finder.aggressive).to be nil
      end
    end

    context 'when file returns 200 with application/zip Content-Type' do
      let(:status_code) { 200 }
      let(:headers) { { 'Content-Type' => 'application/zip' } }

      it 'returns TmmDbMigrate finding' do
        result = finder.aggressive

        expect(result).to be_a WPScan::Model::TmmDbMigrate
        expect(result.url).to eq zip_url
        expect(result.confidence).to eq 100
        expect(result.found_by).to eq 'Direct Access (Aggressive Detection)'
      end
    end

    context 'when file returns 200 with application/zip; charset=binary' do
      let(:status_code) { 200 }
      let(:headers) { { 'Content-Type' => 'application/zip; charset=binary' } }

      it 'returns TmmDbMigrate finding' do
        result = finder.aggressive
        expect(result).to be_a WPScan::Model::TmmDbMigrate
      end
    end

    context 'when file returns 200 but no Content-Type header' do
      let(:status_code) { 200 }
      let(:headers) { {} }

      it 'returns nil' do
        expect(finder.aggressive).to be nil
      end
    end
  end
end
