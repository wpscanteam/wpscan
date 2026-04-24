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
      stub_request(:head, log_url).to_return(head_response)
      stub_request(:get, log_url).to_return(body: body)
    end

    let(:head_response) { { status: 200 } }

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

    context 'when HEAD advertises a Content-Length above the configured limit' do
      let(:body)          { File.read(fixtures.join('debug.log')) }
      let(:head_response) { { status: 200, headers: { 'Content-Length' => (50 * 1024 * 1024).to_s } } }

      before { WPScan::ParsedCli.options = { max_log_file_size: 20 } }
      after  { WPScan::ParsedCli.options = {} }

      it 'skips the GET and returns nil' do
        expect(finder.aggressive).to be_nil
        expect(a_request(:get, log_url)).not_to have_been_made
      end
    end

    context 'when HEAD advertises a Content-Length below the configured limit' do
      let(:body)          { File.read(fixtures.join('debug.log')) }
      let(:head_response) { { status: 200, headers: { 'Content-Length' => '500' } } }

      before { WPScan::ParsedCli.options = { max_log_file_size: 20 } }
      after  { WPScan::ParsedCli.options = {} }

      it 'fetches the body via a streaming GET with maxfilesize set and matches the pattern' do
        allow(WPScan::Browser).to receive(:forge_request).and_call_original
        expect(WPScan::Browser).to receive(:forge_request).with(
          log_url,
          hash_including(maxfilesize: 20 * 1024 * 1024, cache_ttl: 0, method: :get)
        ).and_call_original

        expect(finder.aggressive).to eql WPScan::Model::DebugLog.new(
          log_url,
          confidence: 100,
          found_by: described_class::DIRECT_ACCESS
        )
      end
    end

    context 'when the server does not expose Content-Length (chunked transfer)' do
      let(:head_response) { { status: 200 } }
      let(:body)          { File.read(fixtures.join('debug.log')) }

      before { WPScan::ParsedCli.options = { max_log_file_size: 20 } }
      after  { WPScan::ParsedCli.options = {} }

      it 'still issues a streaming GET with an on_body callback so large payloads can be aborted' do
        captured_req = nil
        allow(WPScan::Browser).to receive(:forge_request).and_wrap_original do |m, *args|
          req = m.call(*args)
          captured_req = req if args.first == log_url && args[1][:method] == :get
          req
        end

        finder.aggressive

        expect(captured_req).not_to be_nil
        expect(captured_req.on_body).not_to be_empty
      end
    end
  end
end
