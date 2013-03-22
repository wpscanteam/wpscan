# encoding: UTF-8

require 'spec_helper'

describe WpVersion do
  subject(:wp_version) { WpVersion.new(uri, options) }
  let(:uri)            { URI.parse('http://example.com') }
  let(:options)        { {} }

  describe '#allowed_options' do
    [:number, :found_from].each do |sym|
      its(:allowed_options) { should include sym }
    end
  end

end
