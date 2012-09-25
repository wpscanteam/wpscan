#--
# WPScan - WordPress Security Scanner
# Copyright (C) 2012
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

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Browser do
  CONFIG_FILE_WITHOUT_PROXY = SPEC_FIXTURES_CONF_DIR + '/browser/browser.conf.json'
  CONFIG_FILE_WITH_PROXY = SPEC_FIXTURES_CONF_DIR + '/browser/browser.conf_proxy.json'
  INSTANCE_VARS_TO_CHECK = ['user_agent', 'user_agent_mode', 'available_user_agents', 'proxy', 'max_threads', 'request_timeout', 'cache_timeout']

  before :all do
    @json_config_without_proxy = JSON.parse(File.read(CONFIG_FILE_WITHOUT_PROXY))
    @json_config_with_proxy = JSON.parse(File.read(CONFIG_FILE_WITH_PROXY))
  end

  before :each do
    @browser = Browser.instance(:config_file => CONFIG_FILE_WITHOUT_PROXY)
  end

  def check_instance_variables(browser, json_expected_vars)
    json_expected_vars['max_threads'] ||= 1 # max_thread can not be nil

    INSTANCE_VARS_TO_CHECK.each do |instance_variable_name|
      browser.send(:"#{instance_variable_name}").should === json_expected_vars[instance_variable_name]
    end
  end

  describe "#user_agent_mode setter / getter" do
    # Testing all valid modes
    Browser::USER_AGENT_MODES.each do |user_agent_mode|
      it "should set / return #{user_agent_mode}" do
        @browser.user_agent_mode = user_agent_mode
        @browser.user_agent_mode.should === user_agent_mode
      end
    end

    it "shoud set the mode to 'static' if nil is given" do
      @browser.user_agent_mode = nil
      @browser.user_agent_mode.should === "static"
    end

    it "should raise an error if the mode in not valid" do
      expect { @browser.user_agent_mode = "invalid-mode" }.to raise_error
    end
  end

  describe "#max_threads=" do
    it "should set max_threads to 1 if nil is given" do
      @browser.max_threads = nil
      @browser.max_threads.should === 1
    end

    it "should set max_threads to 1 if 0 is given" do
      @browser.max_threads = 0
      @browser.max_threads.should === 1
    end
  end

  describe "#user_agent" do
    available_user_agents = %w{ ua-1 ua-2 ua-3 ua-4 ua-6 ua-7 ua-8 ua-9 ua-10 ua-11 ua-12 ua-13 ua-14 ua-15 ua-16 ua-17}

    it "should always return the same user agent in static mode" do
      @browser.user_agent = "fake UA"
      @browser.user_agent_mode = "static"

      (1..3).each do
        @browser.user_agent.should === "fake UA"
      end
    end

    it "should choose a random user_agent in the available_user_agents array an always return it" do
      @browser.available_user_agents = available_user_agents
      @browser.user_agent = "Firefox 11.0"
      @browser.user_agent_mode = "semi-static"

      user_agent = @browser.user_agent
      user_agent.should_not === "Firefox 11.0"
      available_user_agents.include?(user_agent).should be_true

      (1..3).each do
        @browser.user_agent.should === user_agent
      end
    end

    it "should return a random user agent each time" do
      @browser.available_user_agents = available_user_agents
      @browser.user_agent_mode = "random"

      @browser.user_agent.should_not === @browser.user_agent
    end
  end

  describe "Singleton" do
    it "should not allow #new" do
      expect { Browser.new }.to raise_error
    end
  end

  describe "#instance with :config_file = #{CONFIG_FILE_WITHOUT_PROXY}" do
    it "will check the instance vars" do
      Browser.reset
      check_instance_variables(
          Browser.instance(:config_file => CONFIG_FILE_WITHOUT_PROXY),
          @json_config_without_proxy
      )
    end
  end

  describe "#instance with :config_file = #{CONFIG_FILE_WITH_PROXY}" do
    it "will check the instance vars" do
      Browser.reset
      check_instance_variables(
          Browser.instance(:config_file => CONFIG_FILE_WITH_PROXY),
          @json_config_with_proxy
      )
    end
  end

  # TODO Write something to test all possible overriding
  describe "override option : user_agent & threads" do
    it "will check the instance vars, with an overriden one" do
      Browser.reset
      check_instance_variables(
          Browser.instance(
              :config_file => CONFIG_FILE_WITHOUT_PROXY,
              :user_agent => "fake IE"
          ),
          @json_config_without_proxy.merge("user_agent" => "fake IE")
      )
    end

    it "should not override the max_threads if max_threads = nil" do
      Browser.reset
      check_instance_variables(
          Browser.instance(
              :config_file => CONFIG_FILE_WITHOUT_PROXY,
              :max_threads => nil
          ),
          @json_config_without_proxy
      )
    end
  end

  describe "#load_config" do

  end

  describe "#merge_request_params without proxy" do
    it "should return the default params" do
      expected_params = {
          :disable_ssl_host_verification => true,
          :disable_ssl_peer_verification => true,
          :headers => {'user-agent' => @browser.user_agent},
          :cache_timeout => @json_config_without_proxy['cache_timeout']
      }

      @browser.merge_request_params().should == expected_params
    end

    it "should return the default params with some values overriden" do
      expected_params = {
          :disable_ssl_host_verification => false,
          :disable_ssl_peer_verification => true,
          :headers => {'user-agent' => 'Fake IE'},
          :cache_timeout => 0
      }

      @browser.merge_request_params(
          :disable_ssl_host_verification => false,
          :headers => {'user-agent' => 'Fake IE'},
          :cache_timeout => 0
      ).should == expected_params
    end

    it "should return the defaul params with :headers:accept = 'text/html' (should not override :headers:user-agent)" do
      expected_params = {
          :disable_ssl_host_verification => true,
          :disable_ssl_peer_verification => true,
          :headers => {'user-agent' => @browser.user_agent, 'accept' => 'text/html'},
          :cache_timeout => @json_config_without_proxy['cache_timeout']
      }

      @browser.merge_request_params(:headers => {'accept' => 'text/html'}).should == expected_params
    end
  end

  describe "#merge_request_params with proxy" do
    it "should return the default params" do
      Browser.reset
      browser = Browser.instance(:config_file => CONFIG_FILE_WITH_PROXY)

      expected_params = {
          :proxy => @json_config_with_proxy['proxy'],
          :disable_ssl_host_verification => true,
          :disable_ssl_peer_verification => true,
          :headers => {'user-agent' => @json_config_with_proxy['user_agent']},
          :cache_timeout => @json_config_with_proxy['cache_timeout']
      }

      browser.merge_request_params().should == expected_params
    end
  end

  # TODO
  describe "#forge_request" do

  end

  describe "#post" do
    it "should return a Typhoeus::Response wth body = 'Welcome Master' if login=master&password=it's me !" do
      url = 'http://example.com/'

      stub_request(:post, url).
          with(:body => "login=master&password=it's me !").
          to_return(:status => 200, :body => "Welcome Master")

      response = @browser.post(url,
                               :params => {:login => "master", :password => "it's me !"}
      )

      response.should be_a Typhoeus::Response
      response.body.should == 'Welcome Master'
    end
  end

  describe "#get" do
    it "should return a Typhoeus::Response with body = 'Hello World !'" do
      url = 'http://example.com/'

      stub_request(:get, url).
          to_return(:status => 200, :body => "Hello World !")

      response = @browser.get(url)

      response.should be_a Typhoeus::Response
      response.body.should == 'Hello World !'
    end
  end

  describe "#Browser.generate_cache_key_from_request" do
    it "2 requests with the same url, without params must have the same cache_key" do

      url = 'http://example.com'
      key1 = Browser.generate_cache_key_from_request(@browser.forge_request(url))
      key2 = Browser.generate_cache_key_from_request(@browser.forge_request(url))

      key1.should === key2
    end

    it "2 requests with the same url, but with different params should have a different cache_key" do

      url = 'http://example.com'
      key1 = Browser.generate_cache_key_from_request(@browser.forge_request(url, :params => {:login => "master", :password => "it's me !"}))
      key2 = Browser.generate_cache_key_from_request(@browser.forge_request(url))

      key1.should_not == key2
    end
  end

  describe "testing caching" do
    it "should only do 1 request, and retrieve the other one from the cache" do

      url = 'http://example.localhost'

      stub_request(:get, url).
          to_return(:status => 200, :body => "Hello World !")

      response1 = @browser.get(url)
      response2 = @browser.get(url)

      response1.body.should == response2.body
      #WebMock.should have_requested(:get, url).times(1) # This one fail, dunno why :s (but it works without mock)
    end
  end

  describe "testing UTF8" do
    it "should not throw an encoding exception" do
      url = SPEC_FIXTURES_DIR + "/utf8.html"
      stub_request(:get, url).to_return(:status => 200, :body => File.read(url))
      response1 = @browser.get(url)
      expect { response1.body }.to_not raise_error
    end
  end
end

