# encoding: UTF-8

shared_examples 'WebSite::InterestingHeaders' do

  let(:known_headers) { WebSite::InterestingHeaders.known_headers }

  describe '#interesting_headers' do

    it 'returns MyTestHeader' do
      stub_request(:head, web_site.url).
          to_return(status: 200, headers: { 'Mytestheader' => 'Mytestheadervalue' })
      web_site.interesting_headers.should =~ [ [ 'MYTESTHEADER', 'Mytestheadervalue' ] ]
    end

    it 'removes known headers' do
      stub_request(:head, web_site.url).
          to_return(status: 200, headers: { 'Location' => 'a', 'Connection' => 'Close' })
      web_site.interesting_headers.should be_empty
    end

    it 'returns nothing' do
      stub_request(:head, web_site.url).
          to_return(status: 200, headers: { })
      web_site.interesting_headers.should be_empty
    end

  end

  describe '#known_headers' do
    it 'does not contain duplicates' do
      known_headers.flatten.uniq.length.should == known_headers.length
    end
  end

end
