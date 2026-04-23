# frozen_string_literal: true

describe WPScan::Model::XMLRPC do
  subject(:xml_rpc) { described_class.new(url) }
  let(:url)         { 'http://example.com/xmlrpc' }
  let(:fixtures)    { FIXTURES_MODELS.join('xml_rpc') }

  describe '#references' do
    its(:references) { should_not be_empty }
  end

  describe '#type' do
    its(:type) { should eql 'xmlrpc' }
  end

  describe '#to_s' do
    its(:to_s) { should eql 'XML-RPC seems to be enabled: http://example.com/xmlrpc' }
  end

  describe '#method_call' do
    after do
      request = xml_rpc.method_call(method, method_params, request_params)

      expect(request).to be_a Typhoeus::Request
      expect(request.options[:body]).to eql @expected_body

      expect(request.options).to include(request_params) unless request_params.empty?
    end

    let(:method)         { 'rpc-test' }
    let(:method_params)  { [] }
    let(:request_params) { {} }

    context 'when no params' do
      it 'sets the correct body in the request' do
        @expected_body = +'<?xml version="1.0" ?><methodCall>'
        @expected_body << "<methodName>#{method}</methodName><params/>"
        @expected_body << "</methodCall>\n"
      end
    end

    context 'when method_params and request_params' do
      let(:method_params) { %w[p1 p2] }
      let(:request_params)  { { spec_key: 'yolo' } }

      it 'set the correct body in the request' do
        @expected_body = +'<?xml version="1.0" ?><methodCall>'
        @expected_body << "<methodName>#{method}</methodName><params>"
        @expected_body << '<param><value><string>p1</string></value></param>'
        @expected_body << '<param><value><string>p2</string></value></param>'
        @expected_body << "</params></methodCall>\n"
      end
    end
  end

  describe '#multi_call' do
    after do
      request = xml_rpc.multi_call(methods_and_params, request_params)

      expect(request).to be_a Typhoeus::Request
      expect(request.options[:body]).to eql @expected_body

      expect(request.options).to include(request_params) unless request_params.empty?
    end

    let(:methods_and_params) { [%w[m1 p1 p2], %w[m2 p1], %w[m3]] }
    let(:request_params)     { {} }

    it 'sets the correct body in the request' do
      @expected_body = File.read(fixtures.join('multi_call.xml'))
    end
  end

  describe '#available_methods' do
    after do
      expect(xml_rpc.available_methods).to eql @expected

      expect(xml_rpc).to_not receive(:method_call)
      expect(xml_rpc.available_methods).to eql @expected
    end

    context 'when an empty response' do
      it 'returns an empty array' do
        stub_request(:post, xml_rpc.url).and_return(body: '')

        @expected = []
      end
    end

    context 'when a correct response' do
      it 'returns the expected array' do
        stub_request(:post, xml_rpc.url).and_return(
          body: '<?xml version="1.0" ?><methodResponse><params><param><value><array><data>' \
                '<value><string>system.listMethods</string></value>' \
                '<value><string>m1</string></value>' \
                '</data></array></value></param></params></methodResponse>'
        )

        @expected = %w[system.listMethods m1]
      end
    end
  end

  describe '#enabled?' do
    context 'when no methods available' do
      it 'returns false' do
        expect(xml_rpc).to receive(:available_methods).and_return([])
        expect(xml_rpc.enabled?).to be false
      end
    end

    context 'when methods available' do
      it 'returns true' do
        expect(xml_rpc).to receive(:available_methods).and_return(%w[m1 m2])
        expect(xml_rpc.enabled?).to be true
      end
    end
  end
end
