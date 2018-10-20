require 'spec_helper'

describe WPScan::WpVersion do
  describe '#new' do
    context 'when invalid number' do
      it 'raises an error' do
        expect { described_class.new('aa') }.to raise_error WPScan::InvalidWordPressVersion
      end
    end

    context 'when valid number' do
      it 'create the instance' do
        version = described_class.new(4.0)

        expect(version).to be_a described_class
        expect(version.number).to eql '4.0'
      end
    end
  end

  describe '.all' do
    it 'returns the correct values' do
      expect(described_class.all).to eql %w[4.4 4.0 3.9.1 3.8.2 3.8.1 3.8]
    end
  end

  describe '.valid?' do
    after { expect(described_class.valid?(@number)).to eq @expected }

    it 'returns false' do
      @number   = 'aaa'
      @expected = false
    end

    it 'returns true' do
      @number   = '4.0'
      @expected = true
    end
  end

  describe '#vulnerabilities' do
    subject(:version) { described_class.new(number) }

    context 'when no vulns' do
      let(:number) { '4.4' }

      its(:vulnerabilities) { should eql([]) }
    end

    context 'when vulnerable' do
      after do
        expect(version.vulnerabilities).to eq @expected
        expect(version).to be_vulnerable
      end

      context 'when a signle vuln' do
        let(:number) { '3.8' }

        it 'returns the expected result' do
          @expected = [WPScan::Vulnerability.new(
            'WP 3.8 - Vuln 1',
            { url: %w[url-4], osvdb: %w[11], wpvulndb: '3' },
            'AUTHBYPASS'
          )]
        end
      end

      context 'when multiple vulns' do
        let(:number) { '3.8.1' }

        it 'returns the expected results' do
          @expected = [
            WPScan::Vulnerability.new(
              'WP 3.8.1 - Vuln 1',
              { wpvulndb: '1' },
              'SQLI'
            ),
            WPScan::Vulnerability.new(
              'WP 3.8.1 - Vuln 2',
              { url: %w[url-2 url-3], osvdb: %w[10], cve: %w[2014-0166], wpvulndb: '2' },
              nil,
              '3.8.2'
            )
          ]
        end
      end
    end
  end

  describe '#release_date' do
    subject(:version) { described_class.new('3.8.1') }

    its(:release_date) { should eql '2014-01-23' }
  end
end
