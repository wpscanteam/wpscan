# frozen_string_literal: true

describe WPScan::Model::RobotsTxt do
  subject(:file) { described_class.new(url) }
  let(:url)      { 'http://example.com/robots.txt' }
  let(:fixtures) { FIXTURES_FINDERS.join('interesting_findings', 'robots_txt') }

  describe '#interesting_entries' do
    let(:headers) { { 'Content-Type' => 'text/plain; charset=utf-8' } }

    after do
      body = File.read(fixtures.join(fixture))

      stub_request(:get, file.url).to_return(headers: headers, body: body)

      expect(file.interesting_entries).to eq @expected
    end

    context 'when empty or / entries' do
      let(:fixture) { 'robots.txt' }

      it 'ignores them and only returns the others w/o duplicate' do
        @expected = %w[/admin /public/home]
      end
    end
  end

  describe '#type' do
    its(:type) { should eql 'robots_txt' }
  end
end
