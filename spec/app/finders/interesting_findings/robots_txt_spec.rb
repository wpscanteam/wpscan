# frozen_string_literal: true

describe WPScan::Finders::InterestingFindings::RobotsTxt do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://e.org/' }
  let(:robots_url) { "#{url}robots.txt" }
  let(:fixtures)   { FIXTURES_FINDERS.join('interesting_findings', 'robots_txt') }

  before do
    stub_request(:get, /e\.org/).to_return(status: 200)
    expect(finder.target).to receive(:head_or_get_params).and_return(method: :head)
  end

  describe '#aggressive' do
    before { stub_request(:head, robots_url).to_return(status: head_status) }

    context 'when 404' do
      let(:head_status) { 404 }

      its(:aggressive) { should eql nil }
    end

    context 'when 200' do
      let(:head_status) { 200 }

      context 'when the body is empty' do
        it 'returns nil' do
          stub_request(:get, robots_url).to_return(status: 200, body: '')

          expect(finder.aggressive).to eql nil
        end
      end

      context 'when the body matches a robots.txt' do
        it 'returns the InterestingFinding result' do
          stub_request(:get, robots_url).to_return(status: 200, body: File.read(fixtures.join('robots.txt')))

          expect(finder.aggressive).to eql WPScan::Model::RobotsTxt.new(
            robots_url,
            confidence: 100,
            found_by: 'Robots Txt (Aggressive Detection)'
          )
        end
      end
    end
  end
end
