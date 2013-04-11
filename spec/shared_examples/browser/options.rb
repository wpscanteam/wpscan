# encoding: UTF-8

shared_examples 'Browser::Options' do

  describe '#basic_auth=' do
    let(:exception) { 'Invalid basic authentication format, "login:password" or "Basic base_64_encoded" expected' }

    after do
      if @expected
        browser.basic_auth = @auth
        browser.basic_auth.should == @expected
      else
        expect { browser.basic_auth = @auth }.to raise_error(exception)
      end
    end

    context 'when invalid format' do
      it 'raises an error' do
        @auth = 'invalid'
      end
    end

    context 'when login:password' do
      it 'sets the basic auth' do
        @auth     = 'admin:weakpass'
        @expected = 'Basic YWRtaW46d2Vha3Bhc3M='
      end
    end

    context 'when Basic base_64_encoded' do
      context 'when invalid base_64_encoded' do
        it 'raises an error' do
          @auth = 'Basic <script>alert(1)</script>'
        end
      end

      it 'sets the basic auth' do
        @auth     = 'Basic dXNlcm5hbWU6dGhlYmlncGFzc3dvcmRzb3dlYWs='
        @expected = @auth
      end
    end
  end

  describe '#max_threads= & #max_threads' do
    let(:exception) { 'max_threads must be an Integer > 0' }

    after do
      if @expected
        browser.max_threads = @max_threads
        browser.max_threads.should == @expected
      else
        expect { browser.max_threads = @max_threads }.to raise_error(exception)
      end
    end

    context 'when the argument is not an Integer > 0' do
      it 'raises an error' do
        @max_thrads = nil
      end

      it 'raises an error' do
        @max_threads = -3
      end
    end

    context 'when the argument is an Integer' do
      it 'returns the @max_threads' do
        @max_threads = 10
        @expected    = 10
      end
    end
  end

  describe '#user_agent_mode= & #user_agent_mode' do
    # Testing all valid modes
    Browser::USER_AGENT_MODES.each do |user_agent_mode|
      it "sets & returns #{user_agent_mode}" do
        browser.user_agent_mode = user_agent_mode
        browser.user_agent_mode.should === user_agent_mode
      end
    end

    it 'sets the mode to "static" if nil is given' do
      browser.user_agent_mode = nil
      browser.user_agent_mode.should === 'static'
    end

    it 'raises an error if the mode is not valid' do
      expect { browser.user_agent_mode = 'invalid-mode' }.to raise_error
    end
  end

  describe '#user_agent= & #user_agent' do
    let(:available_user_agents) { %w{ ua-1 ua-2 ua-3 ua-4 ua-6 ua-7 ua-8 ua-9 ua-10 ua-11 ua-12 ua-13 ua-14 ua-15 ua-16 ua-17 } }

    context 'when static mode' do
      it 'returns the same user agent' do
        browser.user_agent      = 'fake UA'
        browser.user_agent_mode = 'static'

        (1..3).each do
          browser.user_agent.should === 'fake UA'
        end
      end
    end

    context 'when semi-static mode' do
      it 'chooses a random user_agent in the available_user_agents array and always return it' do
        browser.available_user_agents = available_user_agents
        browser.user_agent            = 'Firefox 11.0'
        browser.user_agent_mode       = 'semi-static'

        user_agent = browser.user_agent
        user_agent.should_not === 'Firefox 11.0'
        available_user_agents.include?(user_agent).should be_true

        (1..3).each do
          browser.user_agent.should === user_agent
        end
      end
    end

    context 'when random' do
      it 'returns a random user agent each time' do
        browser.available_user_agents = available_user_agents
        browser.user_agent_mode       = 'random'

        ua_1 = browser.user_agent
        ua_2 = browser.user_agent
        ua_3 = browser.user_agent

        fail if ua_1 === ua_2 and ua_2 === ua_3
      end
    end
  end

  describe 'proxy=' do
    let(:exception) { 'Invalid proxy format. Should be [protocol://]host:port.' }

    after do
      if @expected
        browser.proxy = @proxy
        browser.proxy.should == @expected
      else
        expect { browser.proxy = @proxy }.to raise_error(exception)
      end
    end

    context 'when invalid format' do
      it 'raises an error' do
        @proxy = 'yolo'
      end
    end

    context 'when valid format' do
      @proxy    = '127.0.0.1:9050'
      @expected = @proxy
    end
  end

  describe 'proxy_auth=' do
    let(:exception) { 'Invalid proxy auth format, expected username:password or {proxy_username: username, proxy_password: password}' }

    after :each do
      if @expected
        browser.proxy_auth = @proxy_auth
        browser.proxy_auth.should === @expected
      else
        expect { browser.proxy_auth = @proxy_auth }.to raise_error
      end
    end

    context 'when the auth supplied is' do
      context 'not a String or a Hash' do
        it 'raises an error' do
          @proxy_auth = 10
        end
      end

      context 'a String with' do
        context 'invalid format' do
          it 'raises an error' do
            @proxy_auth = 'invaludauthformat'
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
            @proxy_auth = { proxy_username: 'username' }
          end
        end

        context 'only :proxy_password' do
          it 'raises an error' do
            @proxy_auth = { proxy_password: 'hello' }
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

  describe '#override_config' do
    after do
      browser.send(:override_config, override_options)
    end

    let(:config) { JSON.parse(File.read(browser.config_file)) }

    context 'when an option value is nil' do
      let(:override_options) { { max_threads: nil } }

      it 'does not set it' do
        browser.should_not_receive(:max_threads=)
      end
    end

    context 'when an option is no allowed' do
      let(:override_options) { { not_allowed: 'owned' } }

      it 'does not set it' do
        browser.should_not_receive(:not_allowed=)
      end
    end

    context 'when valid option' do
      let(:override_options) { { max_threads: 30 } }

      it 'sets it' do
        browser.should_receive(:max_threads=).with(30)
      end
    end

    context 'when multiple options' do
      let(:override_options) {
        { max_threads: 10, not_allowed: 'owned', proxy: 'host:port' }
      }

      it 'sets @max_threads, @proxy' do
        browser.should_not_receive(:not_allowed=)
        browser.should_receive(:max_threads=).with(10)
        browser.should_receive(:proxy=).with('host:port')
      end
    end
  end

end
