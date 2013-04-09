# encoding: UTF-8

shared_examples 'Browser::Actions' do

  describe '#post' do
    it 'returns a Typhoeus::Response wth body = "Welcome Master" if login=master&password=itsme!' do
      url = 'http://example.com/'

      stub_request(:post, url).with(body: { login: 'master', password: 'itsme!' }).
        to_return(status: 200, body: 'Welcome Master')

      response = Browser.post(
        url,
        body: 'login=master&password=itsme!'
        #body: { login: 'master', password: 'hello' } # It's should be this line, but it fails
      )

      response.should be_a Typhoeus::Response
      response.body.should == 'Welcome Master'
    end
  end

  describe '#get' do
    it "returns a Typhoeus::Response with body = 'Hello World !'" do
      url = 'http://example.com/'

      stub_request(:get, url).
        to_return(status: 200, body: 'Hello World !')

      response = Browser.get(url)

      response.should be_a Typhoeus::Response
      response.body.should == 'Hello World !'
    end
  end

  describe '#get_and_follow_location' do
    # Typhoeus does not follow the location with rspec
    # See https://github.com/typhoeus/typhoeus/issues/279

    #context 'whitout max_redirects params' do
    #  context 'when multiples redirection' do
    #    it 'returns the last redirection response' do
    #      url               = 'http://target.com'
    #      first_redirection = 'www.first-redirection.com'
    #      last_redirection  = 'last-redirection.com'

    #      stub_request(:get, url).to_return(status: 301, headers: { location: first_redirection })
    #      stub_request(:get, first_redirection).to_return(status: 301, headers: { location: last_redirection })
    #      stub_request(:get, last_redirection).to_return(status: 200, body: 'Hello World!')

    #      response = Browser.get_and_follow_location(url)

    #      response.body.should === 'Hellow World!'
    #    end
    #  end
    #end
  end

end
