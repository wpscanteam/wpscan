# encoding: UTF-8

require 'spec_helper'

describe WpVersion do
  it_behaves_like 'WpVersion::Vulnerable'
  it_behaves_like 'WpItem::Vulnerable' do
    let(:options)        { { number: '3.2' } }
    let(:vulns_file)     { MODELS_FIXTURES + '/wp_version/vulnerable/versions_vulns.xml' }
    let(:expected_vulns) { Vulnerabilities.new << Vulnerability.new('Here I Am', 'SQLI', ['http://ref1.com']) }
  end

  subject(:wp_version) { WpVersion.new(uri, options) }
  let(:uri)            { URI.parse('http://example.com/') }
  let(:options)        { { number: '1.2' } }

  describe '#allowed_options' do
    [:number, :found_from].each do |sym|
      its(:allowed_options) { should include sym }
    end
  end

end
