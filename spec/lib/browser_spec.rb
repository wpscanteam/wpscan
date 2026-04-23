# frozen_string_literal: true

describe WPScan::Browser do
  it_behaves_like described_class::Actions

  subject(:browser) { described_class.instance(options) }
  before            { described_class.reset }
  let(:options)     { {} }
  let(:default) do
    {
      headers: { 'User-Agent' => "WPScan v#{WPScan::VERSION} (https://wpscan.com/wordpress-security-scanner)",
                 'Referer' => nil },
      accept_encoding: 'gzip, deflate',
      method: :get
    }
  end

  describe '#forge_request' do
    it 'returns a Typhoeus::Request' do
      expect(browser.forge_request('http://example.com')).to be_a Typhoeus::Request
    end
  end

  describe '#default_request_params' do
    its(:default_request_params) { should eq default }

    context 'when some attributes are set' do
      let(:options) do
        {
          url: 'http://wp.lo/',
          cache_ttl: 200, connect_timeout: 10,
          http_auth: { username: 'log', password: 'pwd' },
          cookie_jar: '/tmp/cookie_jar.txt',
          vhost: 'testing',
          headers: { 'Test' => 'aa' },
          proxy_auth: { username: 'u', password: 'pwd' },
          disable_tls_checks: true
        }
      end

      let(:expected) do
        default.merge(
          cache_ttl: 200, connecttimeout: 10,
          userpwd: 'log:pwd', proxyuserpwd: 'u:pwd',
          cookiejar: options[:cookie_jar], cookiefile: options[:cookie_jar],
          ssl_verifypeer: false, ssl_verifyhost: 0, sslversion: :tlsv1
        ).merge(headers: default[:headers].merge('Host' => 'testing', 'Test' => 'aa', 'Referer' => 'http://wp.lo/'))
      end

      its(:default_request_params) { should eq expected }
    end
  end

  describe '#request_params' do
    context 'when no param is given' do
      its(:request_params) { should eq default }
    end

    context 'when params are supplied' do
      let(:params) { { another_param: true, headers: { 'Accept' => 'None' } } }

      it 'merges them (headers should be correctly merged)' do
        expect(browser.request_params(params)).to eq default
          .merge(params) { |key, oldval, newval| key == :headers ? oldval.merge(newval) : newval }
      end

      context 'when browser options' do
        let(:options) { { proxy: 'http://127.0.0.1:8080', headers: { 'T' => 'a' } } }

        it 'returns the correct hash' do
          expect(browser.request_params(params)).to eq default
            .merge(options) { |key, oldval, newval| key == :headers ? oldval.merge(newval) : newval }
            .merge(params) { |key, oldval, newval| key == :headers ? oldval.merge(newval) : newval }
        end
      end
    end
  end

  describe '#load_options' do
    context 'when no options' do
      it 'does not load anything' do
        described_class::OPTIONS.each do |sym|
          expected = case sym
                     when :user_agent
                       browser.default_user_agent
                     when :throttle
                       0.0
                     end

          expect(browser.send(sym)).to eq expected
        end
      end
    end

    context 'when options are supplied' do
      module WPScan
        # Test accessor
        class Browser
          attr_accessor :test
        end
      end

      let(:options) do
        {
          cache_ttl: 200, max_threads: 10, test: 'should not be set', throttle: 0,
          user_agent: 'UA', proxy: false, user_agents_list: 'test.txt'
        }
      end

      it 'merges the browser options only' do
        described_class::OPTIONS.each do |sym|
          expected = options.key?(sym) ? options[sym] : nil

          expect(browser.send(sym)).to eq expected
        end

        expect(browser.test).to be nil
      end
    end
  end

  describe '#hydra' do
    context 'when #max_threads is nil' do
      its('hydra.max_concurrency') { should eq 1 }
    end

    context 'when #max_threads' do
      let(:options) { { max_threads: 20 } }

      its('hydra.max_concurrency') { should eq options[:max_threads] }
    end
  end

  describe '#max_threads=' do
    after do
      browser.max_threads = @threads

      expect(browser.max_threads).to eq @expected
      expect(browser.hydra.max_concurrency).to eq @expected
    end

    context 'when <= 0' do
      it 'sets max_threads to 1' do
        @threads  = -2
        @expected = 1
      end
    end

    context 'when > 0' do
      it 'sets max_threads to 20' do
        @threads  = 20
        @expected = @threads
      end
    end

    context 'when throttle is used' do
      let(:options) { { throttle: 2000 } }

      it 'sets max_threads to 1' do
        @threads  = 20
        @expected = 1
      end
    end
  end

  describe '#throttle=, #throttle' do
    context 'when not used' do
      let(:options) { { max_threads: 20 } }

      its(:throttle) { should eql 0.0 }
      its(:max_threads) { should eql 20 }
    end

    context 'when max_threads and throttle supplied as options' do
      let(:options) { { max_threads: 20, throttle: 200 } }

      its(:throttle) { should eql 0.2 }
      its(:max_threads) { should eql 1 }
    end

    context 'when used' do
      let(:options) { { max_threads: 10 } }

      after do
        browser.throttle = @throttle

        expect(browser.throttle).to eql @throttle.to_i.abs / 1000.0
        expect(browser.max_threads).to eql 1
        expect(browser.hydra.max_concurrency).to eql 1
      end

      context 'when a negative value is supplied' do
        it 'uses the absolute value and set the max_threads to 1' do
          @throttle = -100
        end
      end

      context 'when a positive value is supplied' do
        it 'sets and set the max_threads to 1' do
          @throttle = 1000
        end
      end
    end
  end

  describe '#user_agent' do
    context 'when no --random-user-agent' do
      context 'when no --user-agent' do
        its(:user_agent) { should eql browser.default_user_agent }
      end

      context 'when --user-agent' do
        let(:options) { super().merge(user_agent: 'Test UA') }

        its(:user_agent) { should eql 'Test UA' }
      end
    end

    context 'when --random-user-agent' do
      let(:options) { super().merge(random_user_agent: true) }

      it 'selects a random UA in the user_agents' do
        expect(browser).to receive(:user_agents_list).and_return(FIXTURES.join('user_agents.txt'))

        expect(browser.user_agent).to_not eql browser.default_user_agent

        expect(browser.user_agent).to eql browser.user_agent
      end
    end
  end

  describe '#user_agents' do
    let(:options) { { user_agents_list: FIXTURES.join('user_agents.txt') } }

    its(:user_agents) { should eql %w[UA-1 UA-2] }
  end
end
