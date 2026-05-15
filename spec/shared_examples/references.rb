# frozen_string_literal: true

shared_examples WPScan::References do
  describe '#references_keys' do
    it 'contains the :wpvulndb symbol' do
      expect(subject.class.references_keys)
        .to include(:wpvulndb)
    end
  end

  describe 'references' do
    context 'when no references' do
      its(:wpvulndb_ids)    { should eql([]) }
      its(:wpvulndb_urls)   { should eql([]) }
      its(:references_urls) { should eql([]) }
    end

    context 'when an unknown reference key is provided' do
      let(:references) { { cve: 1, unknown: 12 } }

      its(:references) { should eql(cve: %w[1]) }
    end

    context 'when references provided as string' do
      let(:references) do
        {
          cve: 11,
          wpvulndb: 12
        }
      end

      its(:cves)     { should eql %w[11] }
      its(:cve_urls) { should eql %w[https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-11] }

      its(:wpvulndb_ids)  { should eql %w[12] }
      its(:wpvulndb_urls) { should eql %w[https://wpscan.com/vulnerability/12] }

      its(:references_urls) do
        should eql [
          'https://wpscan.com/vulnerability/12',
          'https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-11'
        ]
      end
    end

    context 'when references provided as array' do
      let(:references) do
        {
          cve: %w[11 22],
          wpvulndb: %w[12 23]
        }
      end

      its(:cves)     { should eql %w[11 22] }
      its(:cve_urls) do
        should eql %w[
          https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-11
          https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-22
        ]
      end

      its(:wpvulndb_ids)  { should eql %w[12 23] }
      its(:wpvulndb_urls) do
        should eql %w[
          https://wpscan.com/vulnerability/12
          https://wpscan.com/vulnerability/23
        ]
      end

      its(:references_urls) do
        should eql [
          'https://wpscan.com/vulnerability/12',
          'https://wpscan.com/vulnerability/23',
          'https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-11',
          'https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-22'
        ]
      end
    end
  end
end
