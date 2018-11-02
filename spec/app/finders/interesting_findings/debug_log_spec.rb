require 'spec_helper'

describe WPScan::Finders::InterestingFindings::DebugLog do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://ex.lo/' }
  let(:fixtures)   { File.join(FINDERS_FIXTURES, 'interesting_findings', 'debug_log') }
  let(:wp_content) { 'wp-content' }
  let(:log_url)    { target.url("#{wp_content}/debug.log") }

  before { expect(target).to receive(:content_dir).at_least(1).and_return(wp_content) }

  describe '#aggressive' do
    before { stub_request(:get, log_url).to_return(body: body) }

    context 'when empty file' do
      let(:body) { '' }

      its(:aggressive) { should be_nil }
    end

    context 'when a log file' do
      let(:body) { File.read(File.join(fixtures, 'debug.log')) }

      it 'returns the InterestingFinding' do
        expect(finder.aggressive).to eql WPScan::DebugLog.new(
          log_url,
          confidence: 100,
          found_by: described_class::DIRECT_ACCESS
        )
      end
    end
  end
end
