# frozen_string_literal: true

describe WPScan::DB::VulnApi do
  subject(:api) { described_class }

  let(:request_headers) do
    {
      'User-Agent' => WPScan::Browser.instance.default_user_agent,
      'Authorization' => "Token token=#{api.token}"
    }
  end

  before do
    # Reset the default_request_params
    api.instance_variable_set(:@default_request_params, nil)
  end

  describe '#uri' do
    its(:uri) { should be_a Addressable::URI }
  end

  describe '#token, @token=' do
    context 'when no token set' do
      before { api.token = nil } # In case it was set by a previous spec

      its(:token) { should be nil }
    end

    context 'when token set' do
      it 'returns it' do
        api.token = 's3cRet'

        expect(api.token).to eql 's3cRet'
      end
    end
  end

  describe '#get' do
    context 'when no token' do
      before { api.token = nil }

      it 'returns an empty hash' do
        expect(api.get('test')).to eql({})
      end
    end

    context 'when a token' do
      before { api.token = 's3cRet' }

      let(:path) { 'path' }

      context 'when params used' do
        it 'ensures they override the defaults' do
          expect(Typhoeus).to receive(:get)
            .with(api.uri.join(path), hash_including(cache_ttl: 0))
            .and_return(Typhoeus::Response.new(code: 404))

          api.get(path, cache_ttl: 0)
        end
      end

      context 'when no timeouts' do
        before do
          stub_request(:get, api.uri.join(path))
            .with(headers: request_headers)
            .to_return(status: code, body: body)
        end

        context 'when 200' do
          let(:code) { 200 }
          let(:body) { { data: 'something' }.to_json }

          it 'returns the expected hash' do
            expect(api.get(path)).to eql('data' => 'something')
          end
        end

        context 'when 403' do
          let(:code) { 403 }
          let(:body) { { status: 'forbidden' }.to_json }

          it 'returns the expected hash' do
            expect(api.get(path)).to eql('status' => 'forbidden')
          end
        end

        context 'when 404' do
          let(:code) { 404 }
          let(:body) { { error: 'Not found' }.to_json }

          it 'returns an empty hash' do
            expect(api.get(path)).to eql({})
          end
        end

        context 'when 429 (API Limit Reached)' do
          let(:code) { 429 }
          let(:body) { { status: 'rate limit hit' }.to_json }

          it 'returns an empty hash' do
            expect(api.get(path)).to eql({})
          end
        end

        context 'when 200 with HTML body (browser check, proxy, etc.)' do
          let(:code) { 200 }
          let(:body) { '<!DOCTYPE html><html><body>Browser check</body></html>' }

          it 'returns a hash with parse_error' do
            result = api.get(path)
            expect(result).to have_key('parse_error')
            expect(result['parse_error']).to be_a(JSON::ParserError)
          end
        end

        context 'when 403 with HTML body' do
          let(:code) { 403 }
          let(:body) { '<html><body>Forbidden</body></html>' }

          it 'returns a hash with parse_error' do
            result = api.get(path)
            expect(result).to have_key('parse_error')
            expect(result['parse_error']).to be_a(JSON::ParserError)
          end
        end
      end

      context 'when timeouts' do
        context 'when all requests timeout' do
          before do
            stub_request(:get, api.uri.join('path'))
              .with(headers: request_headers)
              .to_return(status: 0)
          end

          it 'tries 3 times and returns the hash with the error' do
            expect(api).to receive(:sleep).with(1).exactly(3).times

            result = api.get('path')

            expect(result['http_error']).to be_a WPScan::Error::HTTP
            expect(api.default_request_params[:headers]['X-Retry']).to eql 3
          end
        end

        context 'when only the first request timeout' do
          before do
            stub_request(:get, api.uri.join('path'))
              .with(headers: request_headers)
              .to_return(status: 0).then
              .to_return(status: 200, body: { data: 'test' }.to_json)
          end

          it 'tries 1 time and returns expected data' do
            expect(api).to receive(:sleep).with(1).exactly(1).times

            expect(api.get('path')).to eql('data' => 'test')
            expect(api.default_request_params[:headers]['X-Retry']).to eql 1
          end
        end
      end
    end
  end

  describe '#plugin_data' do
    before { api.token = api_token }

    context 'when no --api-token' do
      let(:api_token) { nil }

      it 'returns an empty hash' do
        expect(api.plugin_data('slug')).to eql({})
      end
    end

    context 'when valid --api-token' do
      let(:api_token) { 's3cRet' }

      context 'when the slug exist' do
        it 'calls the correct URL' do
          stub_request(:get, api.uri.join('plugins/slug'))
            .to_return(status: 200, body: { slug: { p: 'aa' } }.to_json)

          expect(api.plugin_data('slug')).to eql('p' => 'aa')
        end
      end

      context 'when the slug does not exist' do
        it 'returns an empty hash' do
          stub_request(:get, api.uri.join('plugins/slug-404')).to_return(status: 404, body: '{}')

          expect(api.plugin_data('slug-404')).to eql({})
        end
      end

      context 'when API limit reached' do
        it 'returns an empty hash' do
          stub_request(:get, api.uri.join('plugins/slug-429'))
            .to_return(status: 429, body: { status: 'rate limit hit' }.to_json)

          expect(api.plugin_data('slug-429')).to eql({})
        end
      end
    end
  end

  describe '#theme_data' do
    before { api.token = api_token }

    context 'when no --api-token' do
      let(:api_token) { nil }

      it 'returns an empty hash' do
        expect(api.theme_data('slug')).to eql({})
      end
    end

    context 'when valid --api-token' do
      let(:api_token) { 's3cRet' }

      context 'when the slug exist' do
        it 'calls the correct URL' do
          stub_request(:get, api.uri.join('themes/slug'))
            .to_return(status: 200, body: { slug: { t: 'aa' } }.to_json)

          expect(api.theme_data('slug')).to eql('t' => 'aa')
        end
      end

      context 'when the slug does not exist' do
        it 'returns an empty hash' do
          stub_request(:get, api.uri.join('themes/slug-404')).to_return(status: 404, body: '{}')

          expect(api.theme_data('slug-404')).to eql({})
        end
      end

      context 'when API limit reached' do
        it 'returns an empty hash' do
          stub_request(:get, api.uri.join('themes/slug-429'))
            .to_return(status: 429, body: { status: 'rate limit hit' }.to_json)

          expect(api.theme_data('slug-429')).to eql({})
        end
      end
    end
  end

  describe '#wordpress_data' do
    before { api.token = api_token }

    context 'when no --api-token' do
      let(:api_token) { nil }

      it 'returns an empty hash' do
        expect(api.wordpress_data('1.2')).to eql({})
      end
    end

    context 'when valid --api-token' do
      let(:api_token) { 's3cRet' }

      context 'when the version exist' do
        it 'calls the correct URL' do
          stub_request(:get, api.uri.join('wordpresses/522'))
            .to_return(status: 200, body: { '5.2.2' => { w: 'aa' } }.to_json)

          expect(api.wordpress_data('5.2.2')).to eql('w' => 'aa')
        end
      end

      context 'when the version does not exist' do
        it 'returns an empty hash' do
          stub_request(:get, api.uri.join('wordpresses/11')).to_return(status: 404, body: '{}')

          expect(api.wordpress_data('1.1')).to eql({})
        end
      end

      context 'when API limit reached' do
        it 'returns an empty hash' do
          stub_request(:get, api.uri.join('wordpresses/429'))
            .to_return(status: 429, body: { status: 'rate limit hit' }.to_json)

          expect(api.wordpress_data('4.2.9')).to eql({})
        end
      end
    end
  end

  describe '#status' do
    before do
      api.token = 's3cRet'

      stub_request(:get, api.uri.join('status'))
        .with(query: { version: WPScan::VERSION },
              headers: request_headers)
        .to_return(status: code, body: return_body.to_json)
    end

    let(:code) { 200 }
    let(:return_body) { {} }

    context 'when 200' do
      let(:return_body) { { success: true, plan: 'free', requests_remaining: 100 } }

      it 'returns the expected hash' do
        status = api.status

        expect(status['success']).to be true
        expect(status['plan']).to eql 'free'
        expect(status['requests_remaining']).to eql 100
      end

      context 'when unlimited requests' do
        let(:return_body) { super().merge(plan: 'enterprise', requests_remaining: -1) }

        it 'returns the expected hash, witht he correct requests_remaining' do
          status = api.status

          expect(status['success']).to be true
          expect(status['plan']).to eql 'enterprise'
          expect(status['requests_remaining']).to eql 'Unlimited'
        end
      end

      context 'when CF-Connecting-IP provided in CLI' do
        let(:return_body) { { success: true, plan: 'free', requests_remaining: 100 } }

        before do
          WPScan::Browser.instance.headers = { 'CF-Connecting-IP' => '123.123.123.123' }
        end

        it 'does not contain the CF-Connecting-IP header in the request' do
          status = api.status

          expect(status['success']).to be true
          expect(status['plan']).to eql 'free'
          expect(status['requests_remaining']).to eql 100
        end
      end
    end

    # When invalid/empty API token
    context 'when 403' do
      let(:code) { 403 }
      let(:return_body) { { status: 'forbidden' } }

      it 'returns the expected hash' do
        expect(api.status['status']).to eql 'forbidden'
      end
    end

    context 'otherwise' do
      let(:code) { 0 }

      it 'returns the expected hash with the response as an exception' do
        status = api.status

        expect(status['http_error']).to be_a WPScan::Error::HTTP
      end
    end
  end

  describe '#default_request_params' do
    before do
      WPScan::ParsedCli.options = rspec_parsed_options(cli_args)
      WPScan::Browser.instance.load_options(WPScan::ParsedCli.options.dup)
      api.instance_variable_set(:@default_request_params, nil)
    end

    after do
      # Reset the Browser instance state so the proxy/flags set here don't leak into other specs
      WPScan::Browser.instance.proxy = nil
      WPScan::Browser.instance.proxy_auth = nil
    end

    context 'when --proxy is set' do
      let(:cli_args) { '--url http://ex.lo/ --proxy http://127.0.0.1:8080' }

      it 'includes the proxy in the params' do
        expect(api.default_request_params[:proxy]).to eql 'http://127.0.0.1:8080'
      end
    end

    context 'when --proxy is set with --proxy-auth' do
      let(:cli_args) { '--url http://ex.lo/ --proxy http://127.0.0.1:8080 --proxy-auth user:pass' }

      it 'includes the proxy and proxyuserpwd in the params' do
        expect(api.default_request_params[:proxy]).to eql 'http://127.0.0.1:8080'
        expect(api.default_request_params[:proxyuserpwd]).to eql 'user:pass'
      end
    end

    context 'when --proxy is set with --proxy-target-only' do
      let(:cli_args) { '--url http://ex.lo/ --proxy http://127.0.0.1:8080 --proxy-target-only' }

      it 'does not include the proxy in the params' do
        expect(api.default_request_params).to_not have_key(:proxy)
      end
    end

    context 'when --proxy and --proxy-auth are set with --proxy-target-only' do
      let(:cli_args) do
        '--url http://ex.lo/ --proxy http://127.0.0.1:8080 --proxy-auth user:pass --proxy-target-only'
      end

      it 'does not include the proxy or proxyuserpwd in the params' do
        expect(api.default_request_params).to_not have_key(:proxy)
        expect(api.default_request_params).to_not have_key(:proxyuserpwd)
      end
    end

    context 'when only --proxy-target-only is set (no --proxy)' do
      let(:cli_args) { '--url http://ex.lo/ --proxy-target-only' }

      it 'still produces valid params without a proxy' do
        expect(api.default_request_params).to_not have_key(:proxy)
      end
    end
  end
end
