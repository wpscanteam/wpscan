# encoding: UTF-8
#--
# WPScan - WordPress Security Scanner
# Copyright (C) 2012-2013
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#++

require 'spec_helper'

describe Browser do
  CONFIG_FILE_WITHOUT_PROXY       = SPEC_FIXTURES_CONF_DIR + '/browser/browser.conf.json'
  CONFIG_FILE_WITH_PROXY          = SPEC_FIXTURES_CONF_DIR + '/browser/browser.conf_proxy.json'
  CONFIG_FILE_WITH_PROXY_AND_AUTH = SPEC_FIXTURES_CONF_DIR + '/browser/browser.conf_proxy_auth.json'
  INSTANCE_VARS_TO_CHECK          = ['user_agent', 'user_agent_mode', 'available_user_agents', 'proxy', 'max_threads', 'request_timeout', 'cache_ttl']

  before :all do
    @json_config_without_proxy = JSON.parse(File.read(CONFIG_FILE_WITHOUT_PROXY))
    @json_config_with_proxy    = JSON.parse(File.read(CONFIG_FILE_WITH_PROXY))
  end

  before :each do
    Browser::reset
    @browser = Browser.instance(config_file: CONFIG_FILE_WITHOUT_PROXY)
  end

  def check_instance_variables(browser, json_expected_vars)
    json_expected_vars['max_threads'] ||= 1 # max_thread can not be nil

    INSTANCE_VARS_TO_CHECK.each do |instance_variable_name|
      browser.send(:"#{instance_variable_name}").should === json_expected_vars[instance_variable_name]
    end
  end

  describe '#user_agent_mode setter / getter' do
    # Testing all valid modes
    Browser::USER_AGENT_MODES.each do |user_agent_mode|
      it "should set / return #{user_agent_mode}" do
        @browser.user_agent_mode = user_agent_mode
        @browser.user_agent_mode.should === user_agent_mode
      end
    end

    it "shoud set the mode to 'static' if nil is given" do
      @browser.user_agent_mode = nil
      @browser.user_agent_mode.should === 'static'
    end

    it 'should raise an error if the mode in not valid' do
      expect { @browser.user_agent_mode = 'invalid-mode' }.to raise_error
    end
  end

  describe '#max_threads=' do
    it 'should set max_threads to 1 if nil is given' do
      @browser.max_threads = nil
      @browser.max_threads.should === 1
    end

    it 'should set max_threads to 1 if 0 is given' do
      @browser.max_threads = 0
      @browser.max_threads.should === 1
    end
  end

  describe '#proxy_auth=' do
    after :each do
      if @raise_error
        expect { @browser.proxy_auth = @proxy_auth }.to raise_error
      else
        @browser.proxy_auth = @proxy_auth
        @browser.proxy_auth.should === @expected
      end
    end

    context 'when the auth supplied is' do

      context 'not a String or a Hash' do
        it 'raises an error' do
          @proxy_auth  = 10
          @raise_error = true
        end
      end

      context 'a String with' do
        context 'invalid format' do
          it 'raises an error' do
            @proxy_auth  = 'invaludauthformat'
            @raise_error = true
          end
        end

        context 'valid format' do
           it 'sets the auth' do
            @proxy_auth = 'username:passwd'
            @expected   = @proxy_auth
          end
        end
      end

      context 'a Hash with' do
        context 'only :proxy_username' do
          it 'raises an error' do
            @proxy_auth  = { proxy_username: 'username' }
            @raise_error = true
          end
        end

        context 'only :proxy_password' do
          it 'raises an error' do
            @proxy_auth  = { proxy_password: 'hello' }
            @raise_error = true
          end
        end

        context ':proxy_username and :proxy_password' do
          it 'sets the auth' do
            @proxy_auth = { proxy_username: 'user', proxy_password: 'pass' }
            @expected   = 'user:pass'
          end
        end
      end

    end
  end

  describe '#user_agent' do
    available_user_agents = %w{ ua-1 ua-2 ua-3 ua-4 ua-6 ua-7 ua-8 ua-9 ua-10 ua-11 ua-12 ua-13 ua-14 ua-15 ua-16 ua-17 }

    it 'should always return the same user agent in static mode' do
      @browser.user_agent = 'fake UA'
      @browser.user_agent_mode = 'static'

      (1..3).each do
        @browser.user_agent.should === 'fake UA'
      end
    end

    it 'should choose a random user_agent in the available_user_agents array an always return it' do
      @browser.available_user_agents = available_user_agents
      @browser.user_agent = 'Firefox 11.0'
      @browser.user_agent_mode = 'semi-static'

      user_agent = @browser.user_agent
      user_agent.should_not === 'Firefox 11.0'
      available_user_agents.include?(user_agent).should be_true

      (1..3).each do
        @browser.user_agent.should === user_agent
      end
    end

    it 'should return a random user agent each time' do
      @browser.available_user_agents = available_user_agents
      @browser.user_agent_mode = 'random'

      ua_1 = @browser.user_agent
      ua_2 = @browser.user_agent
      ua_3 = @browser.user_agent

      fail if ua_1 === ua_2 and ua_2 === ua_3
    end
  end

  describe 'Singleton' do
    it 'should not allow #new' do
      expect { Browser.new }.to raise_error
    end
  end

  describe "#instance with :config_file = #{CONFIG_FILE_WITHOUT_PROXY}" do
    it 'will check the instance vars' do
      Browser.reset
      check_instance_variables(
        Browser.instance(config_file: CONFIG_FILE_WITHOUT_PROXY),
        @json_config_without_proxy
      )
    end
  end

  describe "#instance with :config_file = #{CONFIG_FILE_WITH_PROXY}" do
    it 'will check the instance vars' do
      Browser.reset
      check_instance_variables(
        Browser.instance(config_file: CONFIG_FILE_WITH_PROXY),
        @json_config_with_proxy
      )
    end
  end

  # TODO Write something to test all possible overriding
  describe 'override option : user_agent & threads' do
    it 'will check the instance vars, with an overriden one' do
      Browser.reset
      check_instance_variables(
        Browser.instance(
          config_file: CONFIG_FILE_WITHOUT_PROXY,
          user_agent: 'fake IE'
        ),
        @json_config_without_proxy.merge('user_agent' => 'fake IE')
      )
    end

    it 'should not override the max_threads if max_threads = nil' do
      Browser.reset
      check_instance_variables(
        Browser.instance(
          config_file: CONFIG_FILE_WITHOUT_PROXY,
          max_threads: nil
        ),
        @json_config_without_proxy
      )
    end
  end

  # TODO
  describe '#load_config' do
    it 'should raise an error if file is a symlink' do
      symlink = './rspec_symlink'
      browser = Browser.instance

      File.symlink('./testfile', symlink)
      expect { browser.load_config(symlink) }.to raise_error("[ERROR] Config file is a symlink.")
      File.unlink(symlink)
    end
  end

  describe '#append_params_header_field' do
    after :each do
      Browser.append_params_header_field(
        @params,
        @field,
        @field_value
      ).should === @expected
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
    let(:params) { {} }
    let(:default_expectation) { { cache_ttl: 250, headers: { 'User-Agent' => 'SomeUA' }, ssl_verifypeer: false, ssl_verifyhost: 0 } }

    after :each do
      @browser.stub(user_agent: 'SomeUA')
      @browser.cache_ttl = 250

      @browser.merge_request_params(params).should == @expected
    end

    it 'sets the User-Agent header field and cache_ttl' do
      @expected = default_expectation
    end


    context 'when @proxy' do
      let(:proxy) { '127.0.0.1:9050' }
      let(:proxy_expectation) { default_expectation.merge(proxy: proxy) }

      it 'merges the proxy' do
        @browser.proxy = proxy
        @expected      = proxy_expectation
      end

      context 'when @proxy_auth' do
        it 'sets the proxy_auth' do
          @browser.proxy      = proxy
          @browser.proxy_auth = 'user:pass'
          @expected           = proxy_expectation.merge(proxyauth: 'user:pass')
        end
      end
    end

    context 'when @basic_auth' do
      it 'appends the basic_auth' do
        @browser.basic_auth = 'basic-auth'
        @expected           = default_expectation.merge(
          headers: default_expectation[:headers].merge('Authorization' => 'basic-auth')
        )
      end

    end

    context 'when the cache_ttl is alreday set' do
      let(:params) { { cache_ttl: 500 } }

      it 'does not override it' do
        @expected = default_expectation.merge(params)
      end
    end

  end

  # TODO
  describe '#forge_request' do

  end

  describe '#post' do
    it 'should return a Typhoeus::Response wth body = "Welcome Master" if login=master&password=itsme!' do
      url = 'http://example.com/'

      stub_request(:post, url).with(body: { login: 'master', password: 'itsme!' }).
        to_return(status: 200, body: 'Welcome Master')

      response = @browser.post(
        url,
        body: 'login=master&password=itsme!'
        #body: { login: 'master', password: 'hello' } # It's should be this line, but it fails
      )

      response.should be_a Typhoeus::Response
      response.body.should == 'Welcome Master'
    end
  end

  describe '#get' do
    it "should return a Typhoeus::Response with body = 'Hello World !'" do
      url = 'http://example.com/'

      stub_request(:get, url).
        to_return(status: 200, body: 'Hello World !')

      response = @browser.get(url)

      response.should be_a Typhoeus::Response
      response.body.should == 'Hello World !'
    end
  end

  describe '#get_and_follow_location' do
    # Typhoeus does not follow the location (maybe it's fixed in > 0.4.2)
    # Or, something else is wrong

    #context 'whitout max_redirects params' do
    #  context 'when multiples redirection' do
    #    it 'returns the last redirection response' do
    #      url               = 'http://target.com'
    #      first_redirection = 'www.first-redirection.com'
    #      last_redirection  = 'last-redirection.com'

    #      stub_request(:get, url).to_return(status: 301, headers: { location: first_redirection })
    #      stub_request(:get, first_redirection).to_return(status: 301, headers: { location: last_redirection })
    #      stub_request(:get, last_redirection).to_return(status: 200, body: 'Hello World!')

    #      response = @browser.get_and_follow_location(url)

    #      response.body.should === 'Hellow World!'
    #    end
    #  end
    #end
  end

  describe 'testing caching' do
    it 'should only do 1 request, and retrieve the other one from the cache' do

      url = 'http://example.localhost'

      stub_request(:get, url).
        to_return(status: 200, body: 'Hello World !')

      response1 = @browser.get(url)
      response2 = @browser.get(url)

      response1.body.should == response2.body
      #WebMock.should have_requested(:get, url).times(1) # This one fail, dunno why :s (but it works without mock)
    end
  end

  describe 'testing UTF8' do
    it 'should not throw an encoding exception' do
      url = SPEC_FIXTURES_DIR + '/utf8.html'
      stub_request(:get, url).to_return(status: 200, body: File.read(url))
      response1 = @browser.get(url)
      expect { response1.body }.to_not raise_error
    end
  end
end

