require 'spec_helper'

describe WPScan::Finders::Users::OembedApi do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://wp.lab/' }
  let(:fixtures)   { File.join(FINDERS_FIXTURES, 'users', 'oembed_api') }

  describe '#aggressive' do
    xit
  end
end
