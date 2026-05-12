# frozen_string_literal: true

describe WPScan::Error::ChecksumsMismatch do
  describe '#to_s' do
    context 'without a Cloudflare Ray ID' do
      subject(:error) { described_class.new('metadata.json') }

      it 'mentions the offending file and the support guidance, but no Ray ID' do
        msg = error.to_s

        expect(msg).to include('metadata.json')
        expect(msg).to include('checksums do not match')
        expect(msg).to include('https://status.wpscan.com/')
        expect(msg).to include('https://wpscan.com/contact/')
        expect(msg).to include('https://github.com/wpscanteam/wpscan/issues')
        expect(msg).not_to include('Cloudflare Ray ID')
      end
    end

    context 'with a Cloudflare Ray ID' do
      subject(:error) { described_class.new('metadata.json', cf_ray: '8abc1234deadbeef-FRA') }

      it 'surfaces the Ray ID' do
        expect(error.to_s).to include('Cloudflare Ray ID: 8abc1234deadbeef-FRA')
      end
    end
  end
end
