# frozen_string_literal: true

describe WPScan::Finders::InterestingFindings::UploadSQLDump do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url).extend(CMSScanner::Target::Server::Apache) }
  let(:url)        { 'http://ex.lo/' }
  let(:dump_url)   { url + 'wp-content/uploads/dump.sql' }
  let(:fixtures)   { FINDERS_FIXTURES.join('interesting_findings', 'upload_sql_dump') }
  let(:wp_content) { 'wp-content' }

  describe '#aggressive' do
    before do
      expect(target).to receive(:content_dir).at_least(1).and_return(wp_content)
      expect(target).to receive(:head_or_get_params).and_return(method: :head)
    end

    after { expect(finder.aggressive).to eql @expected }

    context 'when not a 200' do
      it 'returns nil' do
        stub_request(:head, dump_url).to_return(status: 404)

        @expected = nil
      end
    end

    context 'when a 200' do
      before do
        stub_request(:head, dump_url).to_return(status: 200)

        stub_request(:get, dump_url)
          .with(headers: { 'Range' => 'bytes=0-3000' })
          .to_return(body: File.read(fixtures.join(fixture)))
      end

      context 'when the body does not match a SQL dump' do
        let(:fixture) { 'not_sql.txt' }

        it 'returns nil' do
          @expected = nil
        end
      end

      context 'when the body matches a SQL dump' do
        let(:fixture) { 'dump.sql' }

        it 'returns the interesting findings' do
          @expected = WPScan::Model::UploadSQLDump.new(
            dump_url,
            confidence: 100,
            found_by: described_class::DIRECT_ACCESS
          )
        end
      end
    end
  end
end
