describe WPScan::Finders::InterestingFindings::UploadSQLDump do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url).extend(CMSScanner::Target::Server::Apache) }
  let(:url)        { 'http://ex.lo/' }
  let(:fixtures)   { File.join(FINDERS_FIXTURES, 'interesting_findings', 'upload_sql_dump') }
  let(:wp_content) { 'wp-content' }

  describe '#aggressive' do
    before { expect(target).to receive(:content_dir).at_least(1).and_return(wp_content) }

    after {  expect(finder.aggressive).to eql @expected }

    context 'when not a 200' do
      it 'returns nil' do
        stub_request(:get, finder.dump_url).to_return(status: 404)

        @expected = nil
      end
    end

    context 'when a 200' do
      before do
        stub_request(:get, finder.dump_url)
          .to_return(status: 200, body: File.read(File.join(fixtures, fixture)))
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
          @expected = WPScan::UploadSQLDump.new(
            finder.dump_url,
            confidence: 100,
            found_by: described_class::DIRECT_ACCESS
          )
        end
      end
    end
  end
end
