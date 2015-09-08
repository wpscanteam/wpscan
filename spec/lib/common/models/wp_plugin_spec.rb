# encoding: UTF-8

require 'spec_helper'

describe WpPlugin do
  it_behaves_like 'WpPlugin::Vulnerable'
  it_behaves_like 'WpItem::Vulnerable' do
    let(:options) { { name: 'white-rabbit' } }
    let(:db_file) { MODELS_FIXTURES + '/wp_plugin/vulnerable/plugins.json' }
    let(:expected_refs)  { {
        'id'  => [2993],
        'url' => ['Ref 1', 'Ref 2'],
        'cve' => ['2011-001'],
        'secunia' => ['secunia'],
        'osvdb' => ['osvdb'],
        'metasploit' => ['exploit/ex1'],
        'exploitdb' => ['exploitdb']
    } }
    let(:expected_vulns) { Vulnerabilities.new << Vulnerability.new('Follow me!', 'REDIRECT', expected_refs) }
  end

  subject(:wp_plugin) { WpPlugin.new(uri, options) }
  let(:uri)           { URI.parse('http://example.com') }
  let(:options)       { { name: 'plugin-name' } }

  describe '#forge_uri' do
    its('uri.to_s') { is_expected.to eq 'http://example.com/wp-content/plugins/plugin-name/' }
  end

end
