# encoding: UTF-8

require 'spec_helper'

describe WpTheme do
  it_behaves_like 'WpTheme::Versionable'
  it_behaves_like 'WpTheme::Vulnerable'
  it_behaves_like 'WpItem::Vulnerable' do
    let(:options)        { { name: 'the-oracle' } }
    let(:vulns_file)     { MODELS_FIXTURES + '/wp_theme/vulnerable/themes_vulns.xml' }
    let(:expected_vulns) { Vulnerabilities.new << Vulnerability.new('I see you', 'FPD', ['http://ref.com']) }
  end

  subject(:wp_theme)  { WpTheme.new(uri, options) }
  let(:uri)           { URI.parse('http://example.com/') }
  let(:options)       { { name: 'theme-name' } }
  let(:theme_path)    { 'wp-content/themes/theme-name/' }

  describe '#allowed_options' do
    its(:allowed_options) { should include :style_url }
  end

  describe '#forge_uri' do
    its(:uri) { should == uri.merge(theme_path) }
  end

  describe '#style_url' do
    its(:style_url) { should == uri.merge(theme_path + '/style.css').to_s }

    context 'when its already set' do
      it 'returns it instead of the default one' do
        url                = uri.merge(theme_path + '/custom.css').to_s
        wp_theme.style_url = url

        wp_theme.style_url.should == url
      end
    end
  end

end
