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

  describe '#xml_rpc_url' do
    it 'should return the correct url : http://example.localhost/xmlrpc.php' do
      xmlrpc = 'http://example.localhost/xmlrpc.php'
      stub_request(:get, web_site.url).
        to_return(status: 200, headers: { 'X-Pingback' => xmlrpc })

      web_site.xml_rpc_url.should === xmlrpc
    end

    it 'should return nil' do
      stub_request(:get, web_site.url).to_return(status: 200)
      web_site.xml_rpc_url.should be_nil
    end
  end

  describe '#has_xml_rpc?' do
    it 'should return true' do
      stub_request(:get, web_site.url).
        to_return(status: 200, headers: { 'X-Pingback' => 'xmlrpc' })

      web_site.should have_xml_rpc
    end

    it 'should return false' do
      stub_request(:get, web_site.url).to_return(status: 200)
      web_site.should_not have_xml_rpc
    end
  end

  describe '#page_hash' do
    it 'should return the MD5 hash of the page' do
      url  = 'http://e.localhost/somepage.php'
      body = 'Hello World !'

      stub_request(:get, url).to_return(body: body)

      WebSite.page_hash(url).should === Digest::MD5.hexdigest(body)
    end
  end

  describe '#homepage_hash' do
    it 'should return the MD5 hash of the homepage' do
      body = 'Hello World'

      stub_request(:get, web_site.url).to_return(body: body)
      web_site.homepage_hash.should === Digest::MD5.hexdigest(body)
    end
  end

  describe '#error_404_hash' do
    it 'should return the md5sum of the 404 page' do
      stub_request(:any, /.*/).
        to_return(status: 404, body: '404 page !')

      web_site.error_404_hash.should === Digest::MD5.hexdigest('404 page !')
    end
  end

  describe '#rss_url' do
    it 'should return nil if the url is not found' do
      stub_request(:get, web_site.url).to_return(body: 'No RSS link in this body !')
      web_site.rss_url.should be_nil
    end

    it "should return 'http://lamp-wp/wordpress-3.5/?feed=rss2'" do
      stub_request_to_fixture(url: web_site.url, fixture: fixtures_dir + '/rss_url/wordpress-3.5.htm')
      web_site.rss_url.should === 'http://lamp-wp/wordpress-3.5/?feed=rss2'
    end
  end

  describe '#robots_url' do
    it 'should return the correct url' do
      web_site.robots_url.should === 'http://example.localhost/robots.txt'
    end
  end

  describe '#has_robots?' do
    it 'should return true' do
      stub_request(:get, web_site.robots_url).to_return(status: 200)
      web_site.has_robots?.should be_true
    end

    it 'should return false' do
      stub_request(:get, web_site.robots_url).to_return(status: 404)
      web_site.has_robots?.should be_false
    end
  end
end
