# frozen_string_literal: true

describe WPScan::Finders::InterestingFindings::FullPathDisclosure do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://ex.lo/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('interesting_findings', 'fpd') }
  let(:file_url)   { target.url('wp-includes/rss-functions.php') }

  describe '#aggressive' do
    before do
      expect(target).to receive(:sub_dir).at_least(1).and_return(false)
      stub_request(:get, file_url).to_return(body: body)
    end

    context 'when empty file' do
      let(:body) { '' }

      its(:aggressive) { should be_nil }
    end

    context 'when a log file' do
      let(:body) { File.read(fixtures.join('rss_functions.php')) }

      it 'returns the InterestingFinding' do
        found = finder.aggressive

        expect(found).to eql WPScan::Model::FullPathDisclosure.new(
          file_url,
          confidence: 100,
          found_by: described_class::DIRECT_ACCESS
        )
        expect(found.interesting_entries).to eql %w[/blog/wp-includes/rss-functions.php]
      end
    end
  end
end
