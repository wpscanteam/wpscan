# encoding: UTF-8

require 'spec_helper'

describe WpPlugin do
  subject(:wp_plugin) { WpPlugin.new(uri, options) }
  let(:uri)           { URI.parse('http://example.com') }
  let(:options)       { { name: 'plugin-name' } }

  describe '#forge_uri' do
    its('uri.to_s') { should == 'http://example.com/wp-content/plugins/plugin-name/' }
  end

end
