# encoding: UTF-8

require 'spec_helper'

describe 'WebSite' do
  let(:fixtures_dir) { SPEC_FIXTURES_WPSCAN_WEB_SITE_DIR }
  subject(:web_site) { WebSite.new('http://example.localhost/') }

  it_behaves_like 'WebSite::RobotsTxt'
  it_behaves_like 'WebSite::InterestingHeaders'

  before :all do
    Browser::reset
    Browser.instance(
      config_file: SPEC_FIXTURES_CONF_DIR + '/browser.conf.json',
      cache_ttl: 0
    )
  end

  describe '#new' do
    its(:url) { is_expected.to  be === 'http://example.localhost/' }
  end

  describe '#url=' do
    after :each do
      web_site.url = @uri
      expect(web_site.url).to be === @expected
    end

    context 'when protocol or trailing slash is missing' do
      it 'should add them' do
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
      expect(web_site).not_to be_online
    end

    it 'should be considered online if the status code is != 0' do
      stub_request(:get, web_site.url).to_return(status: 200)
      expect(web_site).to be_online
    end
  end

  describe '#has_basic_auth?' do
    it 'should detect that the wpsite is basic auth protected' do
      stub_request(:get, web_site.url).to_return(status: 401)
      expect(web_site).to have_basic_auth
    end

    it 'should not have a basic auth for a 200' do
      stub_request(:get, web_site.url).to_return(status: 200)
      expect(web_site).not_to have_basic_auth
    end
  end

  describe '#xml_rpc_url' do
    it 'returns the xmlrpc url' do
      expect(web_site.xml_rpc_url).to be === 'http://example.localhost/xmlrpc.php'
    end
  end

  describe '#has_xml_rpc?' do
    it 'returns true' do
      stub_request(:get, web_site.xml_rpc_url).
        to_return(status: 200, body: 'XML-RPC server accepts POST requests only')

      expect(web_site).to have_xml_rpc
    end

    it 'returns false' do
      stub_request(:get, web_site.xml_rpc_url).to_return(status: 200)
      expect(web_site).not_to have_xml_rpc
    end
  end

  describe '#redirection' do
    it 'returns nil if no redirection detected' do
      stub_request(:get, web_site.url).to_return(status: 200, body: '')

      expect(web_site.redirection).to be_nil
    end

    [301, 302].each do |status_code|
      it "returns http://new-location.com if the status code is #{status_code}" do
        new_location = 'http://new-location.com'

        stub_request(:get, web_site.url).
          to_return(status: status_code, headers: { location: new_location })

        stub_request(:get, new_location).to_return(status: 200)

        expect(web_site.redirection).to be === 'http://new-location.com'
      end
    end

    context 'when relative URI in Location' do
      it 'returns the absolute URI' do
        relative_location = '/blog/'
        absolute_location = web_site.uri.merge(relative_location).to_s

        stub_request(:get, web_site.url).to_return(status: 301, headers: { location: relative_location })
        stub_request(:get, absolute_location)

        expect(web_site.redirection).to eql absolute_location
      end

      context 'when starts with a ?' do
        it 'returns the absolute URI' do
          relative_location = '?p=blog'
          absolute_location = web_site.uri.merge(relative_location).to_s

          stub_request(:get, web_site.url).to_return(status: 301, headers: { location: relative_location })
          stub_request(:get, absolute_location)

          expect(web_site.redirection).to eql absolute_location
        end
      end
    end

    context 'when multiple redirections' do
      it 'returns the last redirection' do
        first_redirection  = 'http://www.redirection.com'
        last_redirection   = 'http://redirection.com'

        stub_request(:get, web_site.url).to_return(status: 301, headers: { location: first_redirection })
        stub_request(:get, first_redirection).to_return(status: 302, headers: { location: last_redirection })
        stub_request(:get, last_redirection).to_return(status: 200)

        expect(web_site.redirection).to be === last_redirection
      end
    end
  end

  describe '#page_hash' do
    after { expect(WebSite.page_hash(page)).to eq Digest::MD5.hexdigest(@expected) }

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

    context 'when there are scripts' do
      let(:page) {
        body = "yolo\n\n<script type=\"text/javascript\">alert('Hi');</script>\nworld!"
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
      expect(web_site.homepage_hash).to be === Digest::MD5.hexdigest(body)
    end
  end

  describe '#error_404_hash' do
    it 'returns the md5sum of the 404 page' do
      stub_request(:any, /.*/).
        to_return(status: 404, body: '404 page !')

      expect(web_site.error_404_hash).to be === Digest::MD5.hexdigest('404 page !')
    end
  end

  describe '#rss_url' do
    it 'returns nil if the url is not found' do
      stub_request(:get, web_site.url).to_return(body: 'No RSS link in this body !')
      expect(web_site.rss_url).to be_nil
    end

    it "returns 'http://lamp-wp/wordpress-3.5/?feed=rss2'" do
      stub_request_to_fixture(url: web_site.url, fixture: fixtures_dir + '/rss_url/wordpress-3.5.htm')
      expect(web_site.rss_url).to be === 'http://lamp-wp/wordpress-3.5/?feed=rss2'
    end
  end

  describe '::has_log?' do
    let(:log_url) { web_site.uri.merge('log.txt').to_s }
    let(:pattern) { %r{PHP Fatal error} }

    after do
      stub_request_to_fixture(url: log_url, fixture: fixtures_dir + "/has_log/#{@file}")
      expect(WebSite.has_log?(log_url, pattern)).to eq @expected
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
    # See https://github.com/bblimke/webmock/issues/277
    #it 'only checks the first 700 bytes' do
    #  @file     = 'matches_after_700_bytes.txt'
    #  @expected = false
    #end
  end
end
