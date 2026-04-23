# frozen_string_literal: true

describe Typhoeus::Response do
  subject(:response) { Typhoeus::Response.new(opts) }
  let(:opts)         { { body: 'hello world' } }

  describe '#html' do
    its(:html) { should be_a Nokogiri::HTML::Document }
  end

  describe '#xml' do
    its(:xml) { should be_a Nokogiri::XML::Document }
  end

  describe '#request_size' do
    its(:request_size) { should eql 0 }
  end

  describe '#size' do
    context 'when no headers' do
      its(:size) { should eql 11 }
    end

    context 'when headers' do
      let(:opts) { super().merge(response_headers: "key: value\r\n") }

      its(:size) { should eql 23 }
    end
  end

  describe '#from_vuln_api?' do
    context 'when a response from the Vuln API' do
      %w[
        https://wpscan.com/api/v3/plugins/wpscan
        https://wpscan.com/api/v3/plugins/status-test
        https://wpscan.com/api/v3/themes/test
        https://wpscan.com/api/v3/plugins/test/v3/status
      ].each do |response_url|
        it "returnse false for #{response_url}" do
          expect(described_class.new(return_code: 200, effective_url: response_url).from_vuln_api?).to be true
        end
      end
    end

    context 'when not a response from the Vuln API (/status endpoint is ignored)' do
      %w[
        https://wpscan.com/something
        http://wp.lab/
        https://wp.lab/status
        https://wpscan.com/api/v3/status
      ].each do |response_url|
        it "returns false for #{response_url}" do
          expect(described_class.new(return_code: 200, effective_url: response_url).from_vuln_api?).to be false
        end
      end
    end
  end
end
