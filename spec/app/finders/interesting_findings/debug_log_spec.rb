# frozen_string_literal: true

describe WPScan::Finders::InterestingFindings::DebugLog do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://ex.lo/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('interesting_findings', 'debug_log') }
  let(:wp_content) { 'wp-content' }
  let(:log_url)    { target.url("#{wp_content}/debug.log") }

  before do
    expect(target).to receive(:head_or_get_params).and_return(method: :head)
    expect(target).to receive(:content_dir).at_least(1).and_return(wp_content)
  end

  describe '#aggressive' do
    before do
      stub_request(:head, log_url)
      stub_request(:get, log_url).to_return(body: body)
    end

    context 'when empty file' do
      let(:body) { '' }

      its(:aggressive) { should be_nil }
    end

    context 'when a log file' do
      let(:body) { File.read(fixtures.join('debug.log')) }

      it 'returns the InterestingFinding' do
        expect(finder.aggressive).to eql WPScan::Model::DebugLog.new(
          log_url,
          confidence: 100,
          found_by: described_class::DIRECT_ACCESS
        )
      end
    end
  end
end
