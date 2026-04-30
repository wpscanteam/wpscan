# frozen_string_literal: true

describe WPScan::Formatter::Sarif do
  subject(:formatter) { described_class.new }

  before { formatter.views_directories << FIXTURES_VIEWS }

  its(:format)            { should eq 'sarif' }
  its(:base_format)       { should eq 'json' }
  its(:user_interaction?) { should be false }

  describe '#beautify' do
    def fill_buffer(json_hash)
      # Simulate the JSON formatter's per-key buffer fragments.
      json_hash.each do |k, v|
        formatter.buffer << "#{k.to_json}: #{v.to_json},\n"
      end
    end

    it 'wraps an empty buffer in a valid SARIF skeleton' do
      formatter.buffer << ''
      expect { formatter.beautify }.to output(/"version": "2.1.0"/).to_stdout
    end

    it 'emits a SARIF result for a plugin vulnerability' do
      fill_buffer(
        'target_url' => 'https://target.example/',
        'effective_url' => 'https://target.example/',
        'plugins' => {
          'foo' => {
            'slug' => 'foo',
            'location' => 'https://target.example/wp-content/plugins/foo/',
            'version' => { 'number' => '1.2.3' },
            'vulnerabilities' => [
              {
                'title' => 'Foo plugin XSS',
                'fixed_in' => '1.2.4',
                'cvss' => { 'score' => '7.5', 'vector' => 'AV:N/AC:L/Au:N/C:P/I:P/A:P' },
                'references' => { 'cve' => ['2024-12345'], 'wpvulndb' => ['abc'] }
              }
            ]
          }
        }
      )

      output = capture_stdout { formatter.beautify }
      doc = JSON.parse(output)

      expect(doc['version']).to eq '2.1.0'
      expect(doc['runs'].first['tool']['driver']['name']).to eq 'WPScan'

      rules = doc['runs'].first['tool']['driver']['rules']
      expect(rules.map { |r| r['id'] }).to include 'CVE-2024-12345'

      result = doc['runs'].first['results'].first
      expect(result['ruleId']).to eq 'CVE-2024-12345'
      expect(result['level']).to eq 'error'
      expect(result['message']['text']).to include 'Foo plugin XSS'
      expect(result['message']['text']).to include 'fixed in 1.2.4'

      loc = result['locations'].first
      expect(loc['physicalLocation']['artifactLocation']['uri']).to eq 'https://target.example/wp-content/plugins/foo/'
      expect(loc['logicalLocations'].first['fullyQualifiedName']).to eq 'wordpress.plugin.foo@1.2.3'
      expect(loc['logicalLocations'].first['kind']).to eq 'module'
    end

    it 'emits interesting findings at note level' do
      fill_buffer(
        'interesting_findings' => [
          {
            'url' => 'https://target.example/robots.txt',
            'to_s' => 'robots.txt found: ...',
            'type' => 'robots_txt',
            'references' => {}
          }
        ]
      )

      output = capture_stdout { formatter.beautify }
      doc = JSON.parse(output)

      result = doc['runs'].first['results'].first
      expect(result['level']).to eq 'note'
      expect(result['ruleId']).to eq 'wpscan.interesting-finding.robots_txt'
      expect(result['locations'].first['physicalLocation']['artifactLocation']['uri']).to eq 'https://target.example/robots.txt'
    end

    it 'maps cvss score to level' do
      formatter.send(:level_for, 'cvss' => { 'score' => '9.8' }).tap { |l| expect(l).to eq 'error' }
      formatter.send(:level_for, 'cvss' => { 'score' => '5.0' }).tap { |l| expect(l).to eq 'warning' }
      formatter.send(:level_for, 'cvss' => { 'score' => '2.1' }).tap { |l| expect(l).to eq 'note' }
      formatter.send(:level_for, {}).tap { |l| expect(l).to eq 'error' }
    end

    def capture_stdout
      old = $stdout
      $stdout = StringIO.new
      yield
      $stdout.string
    ensure
      $stdout = old
    end
  end
end
