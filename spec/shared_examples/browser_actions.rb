# frozen_string_literal: true

shared_examples WPScan::Browser::Actions do
  let(:url)     { 'http://example.com/file.txt' }
  let(:browser) { WPScan::Browser }

  describe '#forge_request' do
    # Tested from #get etc
  end

  describe '#get, #post, #head' do
    %i[get post head].each do |method|
      it 'calls the method and returns a Typhoeus::Response' do
        stub_request(method, url)

        expect(browser.send(method, url)).to be_a Typhoeus::Response
      end
    end
  end

  describe '#get_and_follow_location' do
    let(:redirection) { 'http://redirect.me' }

    it 'follows the location' do
      stub_request(:get, url).to_return(status: 301, headers: { location: redirection })
      stub_request(:get, redirection).to_return(status: 200, body: 'Got me')

      response = browser.get_and_follow_location(url)
      expect(response).to be_a Typhoeus::Response
      # Line below is not working due to an issue in Typhoeus/Webmock
      # See https://github.com/typhoeus/typhoeus/issues/279
      # expect(response.body).to eq 'Got me'
    end

    context 'maxredirs is present in the params' do
      it 'overrides the default value' do
        expect(browser).to receive(:get).with(url, hash_including(maxredirs: 10))

        browser.get_and_follow_location(url, maxredirs: 10)
      end
    end

    context 'maxredirs is no present in the params' do
      it 'uses the default value' do
        expect(browser).to receive(:get).with(url, hash_including(maxredirs: 3))

        browser.get_and_follow_location(url)
      end
    end
  end
end
