# frozen_string_literal: true

describe WPScan::Finders::InterestingFindings::SearchReplaceDB2 do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://e.org/' }
  let(:file_url)   { "#{url}searchreplacedb2.php" }
  let(:fixtures)   { FIXTURES_FINDERS.join('interesting_findings', 'search_replace_db_2') }

  before do
    stub_request(:get, /e\.org/).to_return(status: 200)
    expect(finder.target).to receive(:head_or_get_params).and_return(method: :head)
  end

  describe '#aggressive' do
    before do
      stub_request(:head, file_url).to_return(status: head_status)
    end

    context 'when 404' do
      let(:head_status) { 404 }

      its(:aggressive) { should eql nil }
    end

    context 'when 200' do
      let(:head_status) { 200 }

      before { stub_request(:get, file_url).to_return(status: 200, body: body) }

      context 'when the body does not match' do
        let(:body) { 'not this one' }

        its(:aggressive) { should eql nil }
      end

      context 'when the body matches' do
        let(:body) { File.read(fixtures.join('searchreplacedb2.php')) }

        it 'returns the InterestingFinding object' do
          expect(finder.aggressive).to eql WPScan::Model::SearchReplaceDB2.new(
            file_url,
            confidence: 100,
            found_by: 'Search Replace Db2 (Aggressive Detection)'
          )
        end
      end
    end
  end
end
