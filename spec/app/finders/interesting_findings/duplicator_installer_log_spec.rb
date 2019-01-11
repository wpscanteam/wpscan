describe WPScan::Finders::InterestingFindings::DuplicatorInstallerLog do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url).extend(CMSScanner::Target::Server::Apache) }
  let(:url)        { 'http://ex.lo/' }
  let(:fixtures)   { File.join(FINDERS_FIXTURES, 'interesting_findings', 'duplicator_installer_log') }
  let(:filename)   { 'installer-log.txt' }
  let(:log_url)    { target.url(filename) }

  describe '#aggressive' do
    before do
      expect(target).to receive(:sub_dir).at_least(1).and_return(false)
      stub_request(:get, log_url).to_return(body: body)
    end

    context 'when the body does not match' do
      let(:body) { '' }

      its(:aggressive) { should be_nil }
    end

    context 'when the body matches' do
      let(:body) { File.read(File.join(fixtures, filename)) }

      it 'returns the InterestingFinding' do
        expect(finder.aggressive).to eql WPScan::DuplicatorInstallerLog.new(
          log_url,
          confidence: 100,
          found_by: described_class::DIRECT_ACCESS
        )
      end
    end
  end
end
