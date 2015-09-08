# encoding: UTF-8

require 'spec_helper'

describe WpTheme do
  it_behaves_like 'WpTheme::Versionable'
  it_behaves_like 'WpTheme::Vulnerable'
  it_behaves_like 'WpItem::Vulnerable' do
    let(:options)        { { name: 'the-oracle' } }
    let(:db_file)     { MODELS_FIXTURES + '/wp_theme/vulnerable/themes_vulns.json' }
    let(:expected_refs)  { {
        'id' => [2993],
        'url' => ['Ref 1', 'Ref 2'],
        'cve' => ['2011-001'],
        'secunia' => ['secunia'],
        'osvdb' => ['osvdb'],
        'metasploit' => ['exploit/ex1'],
        'exploitdb' => ['exploitdb']
    } }
    let(:expected_vulns) { Vulnerabilities.new << Vulnerability.new('I see you', 'FPD', expected_refs) }
  end

  subject(:wp_theme)  { WpTheme.new(uri, options) }
  let(:uri)           { URI.parse('http://example.com/') }
  let(:options)       { { name: 'theme-name' } }
  let(:theme_path)    { 'wp-content/themes/theme-name/' }

  describe '#allowed_options' do
    its(:allowed_options) { is_expected.to include :referenced_url }
  end

  describe '#forge_uri' do
    its(:uri) { is_expected.to eq uri.merge(theme_path) }
  end

end
