# frozen_string_literal: true

describe WPScan::Model::WpVersion do
  describe '#new' do
    context 'when invalid number' do
      it 'raises an error' do
        expect { described_class.new('aa') }.to raise_error WPScan::Error::InvalidWordPressVersion
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
    before { allow(version).to receive(:db_data).and_return(db_data) }

    context 'when no vulns' do
      let(:number) { '4.4' }
      let(:db_data) { { 'vulnerabilities' => [] } }

      its(:vulnerabilities) { should be_empty }
    end

    context 'when vulnerable' do
      after do
        expect(version.vulnerabilities).to eq @expected
        expect(version).to be_vulnerable
      end

      context 'when a signle vuln' do
        let(:number) { '3.8' }
        let(:db_data) { vuln_api_data_for('wordpresses/38') }

        it 'returns the expected result' do
          @expected = [WPScan::Vulnerability.new(
            'WP 3.8 - Vuln 1',
            references: { url: %w[url-4], wpvulndb: '3' },
            type: 'AUTHBYPASS'
          )]
        end
      end

      context 'when multiple vulns' do
        let(:number) { '3.8.1' }
        let(:db_data) { vuln_api_data_for('wordpresses/381') }

        it 'returns the expected results' do
          @expected = [
            WPScan::Vulnerability.new(
              'WP 3.8.1 - Vuln 1',
              references: { wpvulndb: '1' },
              type: 'SQLI',
              cvss: { score: '5.4', vector: 'VECTOR' }
            ),
            WPScan::Vulnerability.new(
              'WP 3.8.1 - Vuln 2',
              references: { url: %w[url-2 url-3], cve: %w[2014-0166], wpvulndb: '2' },
              fixed_in: '3.8.2'
            )
          ]
        end
      end
    end
  end

  describe '#metadata, #release_date, #status' do
    subject(:version) { described_class.new('3.8.1') }

    before { allow(version).to receive(:db_data).and_return(db_data) }

    context 'when no db_data' do
      let(:db_data) { {} }

      its(:release_date) { should eql '2014-01-23' }
      its(:status) { should eql 'outdated' }

      context 'when the version is not in the metadata' do
        subject(:version) { described_class.new('3.8.2') }

        its(:release_date) { should eql 'Unknown' }
        its(:status) { should eql 'Unknown' }
      end
    end

    context 'when db_data' do
      let(:db_data) { vuln_api_data_for('wordpresses/381') }

      its(:release_date) { should eql '2014-01-23-via-api' }
      its(:status) { should eql 'outdated-via-api' }
    end
  end
end
