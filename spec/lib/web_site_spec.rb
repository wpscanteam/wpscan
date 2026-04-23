# frozen_string_literal: true

describe WPScan::WebSite do
  subject(:web_site) { described_class.new(url, opts) }
  let(:url)          { 'http://e.org' }
  let(:opts)         { {} }

  describe '#url=' do
    context 'when the url is incorrect' do
      after do
        expect { web_site.url = @url }.to raise_error Addressable::URI::InvalidURIError
      end

      it 'raises an error if empty' do
        @url = ''
      end

      it 'raises an error if wrong format' do
        @url = 'jj'
      end
    end

    context 'when valid' do
      it 'creates an Addressable object and adds a traling slash' do
        web_site.url = 'http://site.com'

        expect(web_site.url).to eq('http://site.com/')
        expect(web_site.uri).to be_a Addressable::URI
      end

      it 'does not modify the original url given' do
        url = 'http://site.com'

        web_site.url = url

        expect(url).to eql('http://site.com')
        expect(web_site.url).to eq('http://site.com/')
      end
    end

    context 'when non ascii chars' do
      it 'normalize it' do
        web_site.url = 'http://пример.испытание/'

        expect(web_site.url).to eql 'http://xn--e1afmkfd.xn--80akhbyknj4f/'
      end
    end
  end

  describe '#url' do
    context 'when no path argument' do
      its(:url) { should eql 'http://e.org/' }
    end

    context 'when a path argument' do
      it 'appends the path' do
        expect(web_site.url('file.txt')).to eql "#{url}/file.txt"
      end

      it 'encodes the path' do
        expect(web_site.url('f ile.txt')).to eql "#{url}/f%20ile.txt"
        expect(web_site.url('s/a%.txt')).to eql "#{url}/s/a%25.txt"
        expect(web_site.url('#file.txt#')).to eql "#{url}/%23file.txt%23"
      end

      context 'when relative path' do
        let(:url) { 'http://e.org/dir/' }

        it 'appends it from the host/domain' do
          expect(web_site.url('/sub/file.txt')).to eql 'http://e.org/sub/file.txt'
        end
      end
    end
  end

  describe '#ip' do
    context 'when target host not known' do
      let(:url) { 'http://lab.local' }

      its(:ip) { should eql 'Unknown' }
    end

    context 'when target host known' do
      before { expect(IPSocket).to receive(:getaddress).and_return('127.0.0.1') }

      its(:ip) { should eql '127.0.0.1' }
    end
  end

  describe '#error_404_res' do
    before { stub_request(:any, /[a-z\d]{6}\.html/).to_return(stubbed_response) }

    context 'when no redirect' do
      let(:stubbed_response) { { status: 200, body: 'hello world!' } }

      its('error_404_res.body') { should eql 'hello world!' }
    end
  end

  describe '#error_404_url' do
    its(:error_404_url) { should match ERROR_404_URL_PATTERN }

    it 'returns the same url when called more than once' do
      url1 = web_site.error_404_url
      url2 = web_site.error_404_url

      expect(url1).to eql url2
    end
  end

  describe '#opts' do
    its(:opts) { should eql({}) }

    context 'when opts' do
      let(:opts) { { test: 'mm' } }

      its(:opts) { should eql opts }
    end
  end

  describe '#online?, #http_auth?, #access_forbidden?, #proxy_auth?' do
    before { stub_request(:get, web_site.url(path)).to_return(status: status) }

    [nil, 'file-path.txt'].each do |p|
      context "when path = #{p}" do
        let(:path) { p }

        context 'when response status is a 200' do
          let(:status) { 200 }

          it 'is considered fine' do
            expect(web_site.online?(path)).to be true
            expect(web_site.http_auth?(path)).to be false
            expect(web_site.access_forbidden?(path)).to be false
            expect(web_site.proxy_auth?(path)).to be false
          end
        end

        context 'when offline' do
          let(:status) { 0 }

          it 'returns false' do
            expect(web_site.online?(path)).to be false
          end
        end

        context 'when http auth required' do
          let(:status) { 401 }

          it 'returns true' do
            expect(web_site.http_auth?(path)).to be true
          end
        end

        context 'when access is forbidden' do
          let(:status) { 403 }

          it 'return true' do
            expect(web_site.access_forbidden?(path)).to be true
          end
        end

        context 'when proxy auth required' do
          let(:status) { 407 }

          it 'returns true' do
            expect(web_site.proxy_auth?(path)).to be true
          end
        end
      end
    end
  end

  describe '#head_or_get_params' do
    context 'when not already checked' do
      before do
        stub_request(:get, web_site.url)
        stub_request(:head, web_site.homepage_url).to_return(status: status)
      end

      context 'when HEAD dropped/timeout' do
        let(:status) { 0 }

        its(:head_or_get_params) { should eql(method: :get, maxfilesize: 1) }
      end

      context 'when HEAD not supported' do
        let(:status) { 405 }

        its(:head_or_get_params) { should eql(method: :get, maxfilesize: 1) }
      end

      context 'when HEAD not implemented' do
        let(:status) { 501 }

        its(:head_or_get_params) { should eql(method: :get, maxfilesize: 1) }
      end

      context 'when HEAD supported' do
        let(:status) { 200 }

        its(:head_or_get_params) { should eql(method: :head) }
      end
    end

    context 'when already set' do
      it 'returns it' do
        web_site.instance_variable_set(:@head_or_get_params, method: :head)

        expect(web_site.head_or_get_params).to eql(method: :head)
      end
    end
  end

  describe '#head_and_get' do
    before { expect(web_site).to receive(:head_or_get_params).and_return(method: :head) }

    let(:path) { 'something' }

    context 'when no request params given' do
      before { stub_request(:head, web_site.url(path)).to_return(status: status) }

      context 'when HEAD response status is not in the codes given' do
        let(:status) { 404 }

        after do
          expect(@res).to be_a(Typhoeus::Response)
          expect(@res.code).to eql status
          expect(@res.request.options[:method]).to eql :head
          expect(@res.body).to be_empty
        end

        context 'when codes not provided' do
          it 'uses the default [200] and returns the HEAD response' do
            @res = web_site.head_and_get(path)
          end
        end

        context 'when codes provided' do
          it 'uses them and returns the HEAD response' do
            @res = web_site.head_and_get(path, [400])
          end
        end
      end

      context 'when HEAD response status is in the codes given' do
        before { stub_request(:get, web_site.url(path)).to_return(status: status, body: 'hello') }

        after do
          expect(@res).to be_a(Typhoeus::Response)
          expect(@res.code).to eql status
          expect(@res.request.options[:method]).to eql :get
          expect(@res.body).to eql 'hello'
        end

        context 'when codes not provided' do
          let(:status) { 200 }

          it 'uses the default [200] and returns the GET response' do
            @res = web_site.head_and_get(path)
          end
        end

        context 'when codes provided' do
          let(:status) { 400 }

          it 'uses them and returns the GET response' do
            @res = web_site.head_and_get(path, [400])
          end
        end
      end
    end

    context 'when request params given' do
      let(:status) { 200 }

      before do
        stub_request(:head, web_site.url(path)).with(headers: { 'Key' => 'Hello' })

        stub_request(:get, web_site.url(path))
          .with(query: { k: 'value' })
          .and_return(status: 400, body: 'done')
      end

      it 'perform the requests with the expected params' do
        res = web_site.head_and_get(path,
                                    [200],
                                    head: { headers: { 'Key' => 'Hello' } },
                                    get: { params: { k: 'value' } })

        expect(res).to be_a Typhoeus::Response
        expect(res.code).to eql 400
        expect(res.request.options[:method]).to eql :get
        expect(res.body).to eql 'done'
      end
    end
  end
end
