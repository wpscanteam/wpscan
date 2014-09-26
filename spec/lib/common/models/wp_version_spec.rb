# encoding: UTF-8

require 'spec_helper'

describe WpVersion do
  it_behaves_like 'WpVersion::Vulnerable'
  it_behaves_like 'WpItem::Vulnerable' do
    let(:options)        { { number: '3.2' } }
    let(:vulns_file)     { MODELS_FIXTURES + '/wp_version/vulnerable/versions_vulns.json' }
    let(:expected_refs)  { {
        'id' => [2993],
        'url' => ['Ref 1,Ref 2'],
        'cve' => ['2011-001'],
        'secunia' => ['secunia'],
        'osvdb' => ['osvdb'],
        'metasploit' => ['exploit/ex1'],
        'exploitdb' => ['exploitdb']
    } }
    let(:expected_vulns) { Vulnerabilities.new << Vulnerability.new('Here I Am', 'SQLI', expected_refs) }
  end

  subject(:wp_version) { WpVersion.new(uri, options) }
  let(:uri)            { URI.parse('http://example.com/') }
  let(:options)        { { number: '1.2' } }

  describe '#allowed_options' do
    [:number, :found_from].each do |sym|
      its(:allowed_options) { is_expected.to include sym }
    end
  end

end
