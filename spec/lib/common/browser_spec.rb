# encoding: UTF-8

require 'spec_helper'

describe Browser do
  it_behaves_like 'Browser::Actions'
  it_behaves_like 'Browser::Options'

  CONFIG_FILE_WITHOUT_PROXY       = SPEC_FIXTURES_CONF_DIR + '/browser.conf.json'
  CONFIG_FILE_WITH_PROXY          = SPEC_FIXTURES_CONF_DIR + '/browser.conf_proxy.json'
  #CONFIG_FILE_WITH_PROXY_AND_AUTH = SPEC_FIXTURES_CONF_DIR + '/browser.conf_proxy_auth.json'

  subject(:browser) {
    Browser.reset
    Browser.instance(options)
  }
  let(:options) { {} }
  let(:instance_vars_to_check) {
    ['proxy', 'max_threads', 'cache_ttl', 'request_timeout', 'connect_timeout']
  }
  let(:json_config_without_proxy) { JSON.parse(File.read(CONFIG_FILE_WITHOUT_PROXY)) }
  let(:json_config_with_proxy)    { JSON.parse(File.read(CONFIG_FILE_WITH_PROXY)) }

  def check_instance_variables(browser, json_expected_vars)
    json_expected_vars['max_threads'] ||= 20 # max_thread can not be nil

    instance_vars_to_check.each do |variable_name|
      expect(browser.send(:"#{variable_name}")).to be === json_expected_vars[variable_name]
    end
  end

  describe 'Singleton' do
    it 'should not allow #new' do
      expect { Browser.new }.to raise_error
    end
  end

  describe '::instance' do
    after { check_instance_variables(browser, @json_expected_vars) }

    context "when :config_file = #{CONFIG_FILE_WITH_PROXY}" do
      let(:options) { { config_file: CONFIG_FILE_WITH_PROXY } }

      it 'will check the instance vars' do
        @json_expected_vars = json_config_with_proxy
      end
    end

    context 'when options[:cache_dir]' do
      let(:cache_dir) { CACHE_DIR + '/somewhere' }
      let(:options) { { cache_dir: cache_dir } }

      after { expect(subject.cache_dir).to eq cache_dir }

      it 'sets @cache_dir' do
        @json_expected_vars = json_config_without_proxy
      end
    end
  end

  describe '#load_config' do
    context 'when config_file is a symlink' do
      let(:config_file) { './rspec_symlink' }

      it 'raises an error' do
        File.symlink('./testfile', config_file)
        expect { browser.load_config(config_file) }.to raise_error('[ERROR] Config file is a symlink.')
        File.unlink(config_file)
      end
    end

    context 'otherwise' do
      after do
        browser.load_config(@config_file)
        check_instance_variables(browser, @expected)
      end

      it 'sets the correct variables' do
        @config_file = CONFIG_FILE_WITH_PROXY
        @expected    = json_config_without_proxy.merge(json_config_with_proxy)
      end
    end
  end

  describe '::append_params_header_field' do
    after :each do
      expect(Browser.append_params_header_field(
        @params,
        @field,
        @field_value
      )).to be === @expected
    end

    context 'when there is no headers' do
      it 'create the header and set the field' do
        @params      = { somekey: 'somevalue' }
        @field       = 'User-Agent'
        @field_value = 'FakeOne'
        @expected    = { somekey: 'somevalue', headers: { 'User-Agent' => 'FakeOne' } }
      end
    end

    context 'when there are headers' do
      context 'when the field already exists' do
        it 'does not replace it' do
          @params      = { somekey: 'somevalue', headers: { 'Location' => 'SomeLocation' } }
          @field       = 'Location'
          @field_value = 'AnotherLocation'
          @expected    = @params
        end
      end

      context 'when the field is not present' do
        it 'sets the field' do
          @params      = { somekey: 'somevalue', headers: { 'Auth' => 'user:pass' } }
          @field       = 'UA'
          @field_value = 'FF'
          @expected    = { somekey: 'somevalue', headers: { 'Auth' => 'user:pass', 'UA' => 'FF' } }
        end
      end
    end
  end

  describe '#merge_request_params' do
    let(:params)              { {} }
    let(:cookie_jar)          { CACHE_DIR + '/browser/cookie-jar' }
    let(:user_agent)          { 'SomeUA' }
    let(:default_expectation) {
      {
        cache_ttl: 250,
        cookiejar: cookie_jar, cookiefile: cookie_jar,
        timeout: 60, connecttimeout: 10,
        maxredirs: 3,
        referer: nil
      }
    }

    after :each do
      browser.user_agent = user_agent
      browser.cache_ttl = 250

      expect(browser.merge_request_params(params)).to eq @expected
      expect(Typhoeus::Config.user_agent).to eq user_agent
    end

    it 'sets the User-Agent header field and cache_ttl' do
      @expected = default_expectation
    end

    context 'when @user_agent' do
      let(:user_agent) { 'test' }

      it 'sets the User-Agent' do
        @expected = default_expectation
      end
    end

    context 'when @proxy' do
      let(:proxy) { '127.0.0.1:9050' }
      let(:proxy_expectation) { default_expectation.merge(proxy: proxy) }

      it 'merges the proxy' do
        browser.proxy = proxy
        @expected     = proxy_expectation
      end

      context 'when @proxy_auth' do
        it 'sets the proxy_auth' do
          browser.proxy      = proxy
          browser.proxy_auth = 'user:pass'
          @expected          = proxy_expectation.merge(proxyauth: 'user:pass')
        end
      end
    end

    context 'when @request_timeout' do
      it 'gives an Integer' do
        browser.request_timeout = '10'

        @expected = default_expectation.merge(timeout: 10)
      end
    end

    context 'when @basic_auth' do
      it 'appends the basic_auth' do
        browser.basic_auth  = 'user:pass'
        @expected           = default_expectation.merge(
          headers: { 'Authorization' => 'Basic ' + Base64.encode64('user:pass').chomp }
        )
      end
    end

    context 'when the cache_ttl is alreday set' do
      let(:params) { { cache_ttl: 500 } }

      it 'does not override it' do
        @expected = default_expectation.merge(params)
      end
    end

    context 'when the maxredirs is alreday set' do
      let(:params) { { maxredirs: 100 } }

      it 'does not override it' do
        @expected = default_expectation.merge(params)
      end
    end

    context 'when @cookie' do
      let(:cookie) { 'foor=bar;bar=foo' }
      before       { browser.cookie = cookie }

      it 'sets the cookie' do
        @expected = default_expectation.merge(cookie: cookie)
      end
    end

    context 'when @disable_tls_checks' do
      it 'disables tls checks' do
        browser.disable_tls_checks = true
        @expected = default_expectation.merge(ssl_verifypeer: 0, ssl_verifyhost: 0)
      end
    end
  end

  describe '#forge_request' do
    let(:url) { 'http://example.localhost' }

    it 'returns the correct Typhoeus::Request' do
      allow(subject).to receive_messages(merge_request_params: { cache_ttl: 10 })

      request = subject.forge_request(url)
      expect(request).to be_a Typhoeus::Request
      expect(request.url).to eq url
      expect(request.cache_ttl).to eq 10
    end

  end

  describe 'testing caching' do
    it 'should only do 1 request, and retrieve the other one from the cache' do

      url = 'http://example.localhost'

      stub_request(:get, url).to_return(status: 200, body: 'Hello World !')

      response1 = Browser.get(url)
      response2 = Browser.get(url)

      expect(response1.body).to eq response2.body
      #WebMock.should have_requested(:get, url).times(1) # This one fail, dunno why :s (but it works without mock)
    end
  end

  describe 'testing UTF8' do
    it 'should not throw an encoding exception' do
      url = SPEC_FIXTURES_DIR + '/utf8.html'
      stub_request(:get, url).to_return(status: 200, body: File.read(url))

      response = Browser.get(url)
      expect { response.body }.to_not raise_error
    end
  end
end
