# encoding: UTF-8

require 'spec_helper'

describe WpVersion do
  it_behaves_like 'WpVersion::Vulnerable'

  subject(:wp_version) { WpVersion.new(uri, options) }
  let(:uri)            { URI.parse('http://example.com/') }
  let(:options)        { { number: '1.2' } }

  describe '#allowed_options' do
    [:number, :found_from].each do |sym|
      its(:allowed_options) { is_expected.to include sym }
    end
  end

  describe '#all' do
    let(:versions_file) { File.join(MODELS_FIXTURES, 'wp_version', 'findable', 'advanced_fingerprinting', 'wp_versions.xml') }

    it 'returns the array containign the two versions' do
      expect(WpVersion.all(versions_file)).to eq ['3.2.1', '3.2']
    end
  end

end
