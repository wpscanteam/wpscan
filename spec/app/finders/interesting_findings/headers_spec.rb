# frozen_string_literal: true

describe WPScan::Finders::InterestingFindings::Headers do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://e.org/' }
  let(:fixtures)   { FIXTURES_FINDERS.join('interesting_findings', 'headers') }
  let(:fixture)    { fixtures.join('interesting.txt') }
  let(:headers)    { parse_headers_file(fixture) }

  describe '#passive' do
    before { stub_request(:get, /e\.org/).to_return(headers: headers) }

    after do
      if @expected
        result = finder.passive

        expect(result).to be_a WPScan::Model::Headers
        expect(result).to eql @expected
      end
    end

    context 'when no headers' do
      let(:headers) { {} }

      its(:passive) { should be nil }
    end

    context 'when headers' do
      it 'returns the result' do
        opts      = { confidence: 100, found_by: 'Headers (Passive Detection)' }
        @expected = WPScan::Model::Headers.new(url, opts)
      end
    end
  end
end
