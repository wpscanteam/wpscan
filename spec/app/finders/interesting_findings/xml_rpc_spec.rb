# frozen_string_literal: true

describe WPScan::Finders::InterestingFindings::XMLRPC do
  subject(:finder)  { described_class.new(target) }
  let(:target)      { WPScan::Target.new(url) }
  let(:url)         { 'http://e.org/' }
  let(:xml_rpc_url) { "#{url}xmlrpc.php" }
  let(:fixtures)    { FIXTURES_FINDERS.join('interesting_findings', 'xml_rpc') }

  before { stub_request(:get, /e\.org/).to_return(status: 200) }

  describe '#potential_urls' do
    its(:potential_urls) { should be_empty }
  end

  describe '#passive' do
    before do
      expect(finder).to receive(:passive_headers).and_return(headers_stub)
      expect(finder).to receive(:passive_body).and_return(body_stub)
    end

    context 'when both passives return nil' do
      let(:headers_stub) { nil }
      let(:body_stub)    { nil }

      its(:passive) { should be_empty }
    end

    context 'when one passive is not nil' do
      let(:headers_stub) { nil }
      let(:body_stub)    { 'test' }

      its(:passive) { should eq %w[test] }
    end
  end

  describe '#passive_headers' do
    before { stub_request(:get, url).to_return(headers: headers) }

    let(:headers) { {} }

    context 'when no headers' do
      its(:passive_headers) { should be_nil }
    end

    context 'when headers' do
      context 'when URL is out of scope' do
        let(:headers) { { 'X-Pingback' => 'http://ex.org/yolo' } }

        its(:passive_headers) { should be_nil }
      end

      context 'when URL is in scope' do
        let(:headers) { { 'X-Pingback' => xml_rpc_url } }

        it 'adds the url to #potential_urls and returns the XMLRPC' do
          result = finder.passive_headers

          expect(finder.potential_urls).to eq [xml_rpc_url]

          expect(result).to be_a WPScan::Model::XMLRPC
          expect(result).to eql WPScan::Model::XMLRPC.new(
            xml_rpc_url,
            confidence: 30,
            found_by: 'Headers (Passive Detection)'
          )
        end
      end
    end
  end

  describe '#passive_body' do
    before { stub_request(:get, url).to_return(body: body) }

    context 'when no link rel="pingback" tag' do
      let(:body) { '' }

      its(:passive_body) { should be_nil }
    end

    context 'when the tag is present' do
      context 'when the URL is out of scope' do
        let(:body) { File.read(fixtures.join('homepage_out_of_scope_pingback.html')) }

        its(:passive_body) { should be_nil }
      end

      context 'when URL is in scope' do
        let(:body)         { File.read(fixtures.join('homepage_in_scope_pingback.html')) }
        let(:expected_url) { 'http://e.org/wp/xmlrpc.php' }

        it 'adds the URL to the #potential_urls and returns the XMLRPC' do
          result = finder.passive_body

          expect(finder.potential_urls).to eq [expected_url]

          expect(result).to be_a WPScan::Model::XMLRPC
          expect(result).to eql WPScan::Model::XMLRPC.new(
            expected_url,
            confidence: 30,
            found_by: 'Link Tag (Passive Detection)'
          )
        end
      end
    end
  end

  describe '#aggressive' do
    before { finder.potential_urls << 'htpp://ex.org' }

    after do
      stub_request(:post, xml_rpc_url).to_return(body: body)

      expect(finder.aggressive).to eql @expected
    end

    context 'when the body does not match' do
      let(:body) { '' }

      it 'returns nil' do
        @expected = nil
      end
    end

    context 'when the body matches' do
      let(:body) { File.read(fixtures.join('xmlrpc.php')) }

      it 'returns the InterestingFinding result' do
        @expected = WPScan::Model::XMLRPC.new(
          xml_rpc_url,
          confidence: 100,
          found_by: described_class::DIRECT_ACCESS
        )
      end
    end
  end
end
