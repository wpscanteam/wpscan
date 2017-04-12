# encoding: UTF-8

shared_examples 'Browser::Options' do

  describe '#basic_auth=' do
    let(:exception) { /^Invalid basic authentication format, "login:password" or "Basic base_64_encoded" expected. Your input: .+$/ }

    after do
      if @expected
        browser.basic_auth = @auth
        expect(browser.basic_auth).to eq @expected
      else
        expect { browser.basic_auth = @auth }.to raise_error(RuntimeError, exception)
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
        expect(browser.max_threads).to eq @expected
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

  describe 'proxy=' do
    let(:exception) { 'Invalid proxy format. Should be [protocol://]host:port.' }

    after do
      if @expected
        browser.proxy = @proxy
        expect(browser.proxy).to eq @expected
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
        expect(browser.proxy_auth).to be === @expected
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
        expect(browser).not_to receive(:max_threads=)
      end
    end

    context 'when an option is no allowed' do
      let(:override_options) { { not_allowed: 'owned' } }

      it 'does not set it' do
        expect(browser).not_to receive(:not_allowed=)
      end
    end

    context 'when valid option' do
      let(:override_options) { { max_threads: 30 } }

      it 'sets it' do
        expect(browser).to receive(:max_threads=).with(30)
      end
    end

    context 'when multiple options' do
      let(:override_options) {
        { max_threads: 10, not_allowed: 'owned', proxy: 'host:port' }
      }

      it 'sets @max_threads, @proxy' do
        expect(browser).not_to receive(:not_allowed=)
        expect(browser).to receive(:max_threads=).with(10)
        expect(browser).to receive(:proxy=).with('host:port')
      end
    end
  end

end
