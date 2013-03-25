# encoding: UTF-8

require 'spec_helper'

describe WpPlugin do
  it_behaves_like 'WpPlugin::Vulnerable'
  it_behaves_like 'WpItem::Vulnerable' do
    let(:options)        { { name: 'white-rabbit' } }
    let(:vulns_file)     { MODELS_FIXTURES + '/wp_plugin/vulnerable/plugins_vulns.xml' }
    let(:expected_vulns) { Vulnerabilities.new << Vulnerability.new('Follow me!', 'REDIRECT', ['http://ref2.com']) }
  end

  subject(:wp_plugin) { WpPlugin.new(uri, options) }
  let(:uri)           { URI.parse('http://example.com') }
  let(:options)       { { name: 'plugin-name' } }

  describe '#forge_uri' do
    its('uri.to_s') { should == 'http://example.com/wp-content/plugins/plugin-name/' }
  end

end
