# frozen_string_literal: true

describe WPScan::Model::FantasticoFileslist do
  subject(:file) { described_class.new(url) }
  let(:url)      { 'http://example.com/robots.txt' }
  let(:fixtures) { FIXTURES_FINDERS.join('interesting_findings', 'fantastico_fileslist') }

  describe '#interesting_entries' do
    let(:headers) { { 'Content-Type' => 'text/plain; charset=utf-8' } }

    after do
      body = File.read(fixtures.join(fixture))

      stub_request(:get, file.url).to_return(headers: headers, body: body)

      expect(file.interesting_entries).to eq @expected
    end

    context 'when empty or / entries' do
      let(:fixture) { 'fantastico_fileslist.txt' }

      it 'ignores them and only returns the others' do
        @expected = %w[data.sql admin.txt]
      end
    end
  end

  describe '#references' do
    its(:references) { should_not be_nil }
  end

  describe '#type' do
    its(:type) { should eql 'fantastico_fileslist' }
  end
end
