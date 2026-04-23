# frozen_string_literal: true

describe WPScan::Model::SearchReplaceDB2 do
  subject(:file) { described_class.new(url) }
  let(:url)      { 'http://example.com/searchreplacedb2.php' }

  describe '#references' do
    its(:references) { should_not be_nil }
  end

  describe '#type' do
    its(:type) { should eql 'search_replace_db2' }
  end
end
