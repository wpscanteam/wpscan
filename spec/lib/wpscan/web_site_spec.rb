# encoding: UTF-8

require 'spec_helper'

describe 'WebSite' do
  let(:fixtures_dir) { SPEC_FIXTURES_WPSCAN_WEB_SITE_DIR }
  subject(:web_site) { WebSite.new('http://example.localhost/') }

  before :all do
    Browser::reset
    Browser.instance(
      config_file: SPEC_FIXTURES_CONF_DIR + '/browser/browser.conf.json',
      cache_ttl: 0
    )
  end

  describe "#new" do
    its(:url) { should  === 'http://example.localhost/' }
  end

  describe '#url=' do
    after :each do
      web_site.url = @uri
      web_site.url.should === @expected
    end

    context 'when protocol or trailing slash is missing' do
      it 'should add the them' do
        @uri      = 'example.localhost'
        @expected = 'http://example.localhost/'
      end
    end

    context 'when there is a protocol or a trailing slash' do
      it 'should not add them' do
        @uri      = 'http://example.localhost/'
        @expected = @uri
      end
    end
  end

  describe '#online?' do
    it 'should not be considered online if the status code is 0' do
      stub_request(:get, web_site.url).to_return(status: 0)
      web_site.should_not be_online
    end

    it 'should be considered online if the status code is != 0' do
      stub_request(:get, web_site.url).to_return(status: 200)
      web_site.should be_online
    end
  end

  describe '#has_basic_auth?' do
    it 'should detect that the wpsite is basic auth protected' do
      stub_request(:get, web_site.url).to_return(status: 401)
      web_site.should have_basic_auth
    end

    it 'should not have a basic auth for a 200' do
      stub_request(:get, web_site.url).to_return(status: 200)
      web_site.should_not have_basic_auth
    end
  end

  describe '#xml_rpc_url_from_headers' do
    context 'when the x-pingback is' do

      context 'correctly supplied' do
        it 'returns the url in the header : http://example.localhost/xmlrpc.php' do
          xmlrpc = 'http://example.localhost/xmlrpc.php'
          stub_request(:get, web_site.url).
            to_return(status: 200, headers: { 'X-Pingback' => xmlrpc })

          web_site.xml_rpc_url_from_headers.should === xmlrpc
        end
      end

      context 'not supplied' do
        it 'returns nil' do
          stub_request(:get, web_site.url).to_return(status: 200)
          web_site.xml_rpc_url_from_headers.should be_nil
        end

        context 'but there is another header field' do
          it 'returns nil' do
            stub_request(:get, web_site.url).
              to_return(status:200, headers: { 'another-field' => 'which we do not care' })

            web_site.xml_rpc_url_from_headers.should be_nil
          end
        end
      end

      context 'empty' do
        it 'returns nil' do
          stub_request(:get, web_site.url).
            to_return(status: 200, headers: { 'X-Pingback' => '' })

          web_site.xml_rpc_url_from_headers.should be_nil
        end
      end

    end
  end

  describe '#xml_rpc_url_from_body' do
    context 'when the pattern does not match' do
      it 'returns nil' do
        stub_request_to_fixture(url: web_site.url, fixture: fixtures_dir + '/xml_rpc_url/body_dont_match.html')

        web_site.xml_rpc_url_from_body.should be_nil
      end
    end

    context 'when the pattern match' do
      it 'return the url' do
        stub_request_to_fixture(url: web_site.url, fixture: fixtures_dir + '/xml_rpc_url/body_match.html')

        web_site.xml_rpc_url_from_body.should == 'http://lamp/wordpress-3.5.1/xmlrpc.php'
      end
    end
  end

  describe '#xml_rpc_url' do
    after :each do
      web_site.xml_rpc_url.should === xmlrpc_url
    end

    context 'when found in the headers' do
      let(:xmlrpc_url) { 'http://from-headers.localhost/xmlrpc.php' }

      it 'returns the url' do
        web_site.stub(xml_rpc_url_from_headers: xmlrpc_url)
      end
    end

    context 'when found in the body' do
      let(:xmlrpc_url) { 'http://from-body.localhost/xmlrpc.php' }

      it 'returns the url' do
        web_site.stub(
          xml_rpc_url_from_headers: nil,
          xml_rpc_url_from_body: xmlrpc_url
        )
      end
    end

    context 'when not found' do
      let(:xmlrpc_url) { nil }

      it 'returns nil' do
        web_site.stub(
          xml_rpc_url_from_headers: nil,
          xml_rpc_url_from_body: nil
        )
      end
    end
  end

  describe '#has_xml_rpc?' do
    it 'returns true' do
      stub_request(:get, web_site.url).
        to_return(status: 200, headers: { 'X-Pingback' => 'xmlrpc' })

      web_site.should have_xml_rpc
    end

    it 'returns false' do
      stub_request(:get, web_site.url).to_return(status: 200)
      web_site.should_not have_xml_rpc
    end
  end

  describe '#page_hash' do
    after { WebSite.page_hash(page).should == Digest::MD5.hexdigest(@expected) }

    context 'when the page is an url' do
      let(:page) { 'http://e.localhost/somepage.php' }

      it 'returns the MD5 hash of the page' do
        body = 'Hello World !'
        stub_request(:get, page).to_return(body: body)

        @expected = body
      end
    end

    context 'when the page is a Typhoeus::Response' do
      let(:page) { Typhoeus::Response.new(body: 'Hello Example!') }

      it 'returns the correct hash' do
        @expected = 'Hello Example!'
      end
    end

    context 'when there are comments' do
      let(:page) {
        body = "yolo\n\n<!--I should <script>no longer be</script> there -->\nworld!"
        Typhoeus::Response.new(body: body)
      }

      it 'removes them' do
        @expected = "yolo\n\n\nworld!"
      end
    end
  end

  describe '#homepage_hash' do
    it 'returns the MD5 hash of the homepage' do
      body = 'Hello World'

      stub_request(:get, web_site.url).to_return(body: body)
      web_site.homepage_hash.should === Digest::MD5.hexdigest(body)
    end
  end

  describe '#error_404_hash' do
    it 'returns the md5sum of the 404 page' do
      stub_request(:any, /.*/).
        to_return(status: 404, body: '404 page !')

      web_site.error_404_hash.should === Digest::MD5.hexdigest('404 page !')
    end
  end

  describe '#rss_url' do
    it 'returns nil if the url is not found' do
      stub_request(:get, web_site.url).to_return(body: 'No RSS link in this body !')
      web_site.rss_url.should be_nil
    end

    it "returns 'http://lamp-wp/wordpress-3.5/?feed=rss2'" do
      stub_request_to_fixture(url: web_site.url, fixture: fixtures_dir + '/rss_url/wordpress-3.5.htm')
      web_site.rss_url.should === 'http://lamp-wp/wordpress-3.5/?feed=rss2'
    end
  end

  describe '#robots_url' do
    it 'returns the correct url' do
      web_site.robots_url.should === 'http://example.localhost/robots.txt'
    end
  end

  describe '#has_robots?' do
    it 'returns true' do
      stub_request(:get, web_site.robots_url).to_return(status: 200)
      web_site.has_robots?.should be_true
    end

    it 'returns false' do
      stub_request(:get, web_site.robots_url).to_return(status: 404)
      web_site.has_robots?.should be_false
    end
  end

  describe '::has_log?' do
    let(:log_url) { web_site.uri.merge('log.txt').to_s }
    let(:pattern) { %r{PHP Fatal error} }

    after do
      stub_request_to_fixture(url: log_url, fixture: fixtures_dir + "/has_log/#{@file}")
      WebSite.has_log?(log_url, pattern).should == @expected
    end

    context 'when the pattern does not match' do
      it 'returns false' do
        @file     = 'no_match.txt'
        @expected = false
      end
    end

    context 'when the pattern matches' do
      it 'returns true' do
        @file     = 'matches.txt'
        @expected = true
      end
    end

    # This doesn't work in rspec, WebMock or Typhoeus returns the whole file
    #it 'only checks the first 700 bytes' do
    #  @file     = 'matches_after_700_bytes.txt'
    #  @expected = false
    #end
  end
end
