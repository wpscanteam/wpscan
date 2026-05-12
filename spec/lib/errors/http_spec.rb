# frozen_string_literal: true

describe WPScan::Error::Download do
  subject(:error) { described_class.new(response) }

  let(:response) do
    Typhoeus::Response.new(
      effective_url: effective_url,
      code: 503,
      return_message: 'ok',
      response_headers: response_headers
    )
  end
  let(:response_headers) { '' }

  describe '#to_s' do
    context 'when the failing URL is on data.wpscan.org' do
      let(:effective_url) { 'https://data.wpscan.org/metadata.json' }

      it 'includes the URL, status, and the support guidance' do
        msg = error.to_s

        expect(msg).to include('https://data.wpscan.org/metadata.json')
        expect(msg).to include('status: 503')
        expect(msg).to include('https://status.wpscan.com/')
        expect(msg).to include('https://wpscan.com/contact/')
        expect(msg).to include('https://github.com/wpscanteam/wpscan/issues')
      end

      context 'when a CF-Ray header is set' do
        let(:response_headers) { "HTTP/1.1 503 Service Unavailable\r\nCF-Ray: 8abc1234deadbeef-FRA\r\n\r\n" }

        it 'surfaces the Cloudflare Ray ID' do
          expect(error.to_s).to include('Cloudflare Ray ID: 8abc1234deadbeef-FRA')
        end
      end

      context 'when no CF-Ray header is set' do
        it 'does not mention a Ray ID' do
          expect(error.to_s).not_to include('Cloudflare Ray ID')
        end
      end
    end

    context 'when the failing URL is not on data.wpscan.org' do
      let(:effective_url) { 'https://example.com/file' }

      it 'does not include the support guidance' do
        msg = error.to_s

        expect(msg).to include('https://example.com/file')
        expect(msg).not_to include('status.wpscan.com')
        expect(msg).not_to include('wpscan.com/contact')
      end
    end
  end
end
