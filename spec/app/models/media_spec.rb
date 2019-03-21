# frozen_string_literal: true

describe WPScan::Model::Media do
  subject(:media) { described_class.new(url) }
  let(:url)       { 'http://e.oeg/?attachment_id=2' }

  describe '#new' do
    its(:url) { should eql url }
  end
end
