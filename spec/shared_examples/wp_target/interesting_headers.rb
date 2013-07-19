# encoding: UTF-8

shared_examples 'WpTarget::InterestingHeaders' do

  let(:known_headers) { WpTarget::InterestingHeaders.known_headers }
  let(:url) { 'http://localhost.com' }

  describe '#interesting_headers' do

    it 'returns MyTestHeader' do
      stub_request(:head, wp_target.url).
          to_return(status: 200, headers: { 'Mytestheader' => 'Mytestheadervalue' })
      wp_target.interesting_headers.should =~ [ [ 'Mytestheader', 'Mytestheadervalue' ] ]
    end

    it 'removes known headers' do
      stub_request(:head, wp_target.url).
          to_return(status: 200, headers: { 'Location' => 'a', 'Connection' => 'Close' })
      wp_target.interesting_headers.should be_empty
    end

    it 'returns nothing' do
      stub_request(:head, wp_target.url).
          to_return(status: 200, headers: { })
      wp_target.interesting_headers.should be_empty
    end

  end

  describe '#known_headers' do
    it 'does not contain duplicates' do
      known_headers.flatten.uniq.length.should == known_headers.length
    end
  end

end
