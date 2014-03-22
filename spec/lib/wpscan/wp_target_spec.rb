# encoding: UTF-8

require File.expand_path(File.dirname(__FILE__) + '/wpscan_helper')

describe WpTarget do
  subject(:wp_target) { WpTarget.new(target_url, options) }
  let(:target_url)    { 'http://example.localhost/' }
  let(:fixtures_dir)  { SPEC_FIXTURES_WPSCAN_WP_TARGET_DIR }
  let(:login_url)     { wp_target.uri.merge('wp-login.php').to_s }
  let(:options)       {
    {
      config_file:    SPEC_FIXTURES_CONF_DIR + '/browser.conf.json',
      cache_ttl:      0,
      wp_content_dir: 'wp-content',
      wp_plugins_dir: 'wp-content/plugins'
    }
  }

  before { Browser::reset }

  it_behaves_like 'WpTarget::Malwares'
  it_behaves_like 'WpTarget::WpReadme'
  it_behaves_like 'WpTarget::WpRegistrable'
  it_behaves_like 'WpTarget::WpConfigBackup'
  it_behaves_like 'WpTarget::WpLoginProtection'
  it_behaves_like 'WpTarget::WpCustomDirectories'
  it_behaves_like 'WpTarget::WpFullPathDisclosure'

  describe '#initialize' do
    it 'should raise an error if the target_url is nil or empty' do
      expect { WpTarget.new(nil) }.to raise_error
      expect { Wptarget.new('') }.to raise_error
    end
  end

  describe '#login_url' do
    it 'returns the login url of the target' do
      stub_request(:get, login_url).to_return(status: 200, body: '')

      wp_target.login_url.should === login_url
    end

    it 'returns the redirection url if there is one (ie: for https)' do
      https_login_url = login_url.gsub(/^http:/, 'https:')

      stub_request(:get, login_url).to_return(status: 302, headers: { location: https_login_url })
      stub_request(:get, https_login_url).to_return(status: 200)

      wp_target.login_url.should === https_login_url
    end
  end

  describe '#wordpress?' do
    # each url (wp-login and xmlrpc) pointed to a 404
    before :each do
      stub_request(:get, wp_target.url).
        to_return(status: 200, body: '', headers: { 'X-Pingback' => wp_target.uri.merge('xmlrpc.php')})

      # Preventing redirection check from login_url()
      wp_target.stub(redirection: nil)

      [wp_target.login_url, wp_target.xml_rpc_url].each do |url|
        stub_request(:get, url).to_return(status: 404, body: '')
      end
    end

    it 'returns true if there is a /wp-content/ detected in the index page source' do
      stub_request_to_fixture(url: wp_target.url, fixture: fixtures_dir + '/wp_content_dir/wordpress-3.4.1.htm')

      wp_target.should be_wordpress
    end

    it 'returns true if the xmlrpc is found' do
      stub_request(:get, wp_target.xml_rpc_url).
        to_return(status: 200, body: File.new(fixtures_dir + '/xmlrpc.php'))

      wp_target.should be_wordpress
    end

    it 'returns true if the wp-login is found and is a valid wordpress one' do
      stub_request(:get, wp_target.login_url).
        to_return(status: 200, body: File.new(fixtures_dir + '/wp-login.php'))

      wp_target.should be_wordpress
    end

    it 'returns false if both files are not found (404)' do
      wp_target.should_not be_wordpress
    end

    context 'when the url contains "wordpress" and is a 404' do
      let(:target_url) { 'http://lamp/wordpress-3.5./' }

      it 'returns false' do
        stub_request(:get, wp_target.login_url).to_return(status: 404, body: 'The requested URL /wordpress-3.5. was not found on this server.')

        wp_target.should_not be_wordpress
      end
    end
  end

  describe '#wordpress_hosted?' do
    it 'returns true if target url is a wordpress.com subdomain' do
      target = WpTarget.new('http://test.wordpress.com/')
      target.wordpress_hosted?.should be_true
    end

    it 'returns true if target url is a wordpress.com subdomain and has querystring' do
      target = WpTarget.new('http://test.wordpress.com/path/file.php?a=b')
      target.wordpress_hosted?.should be_true
    end

    it 'returns false if target url is not a wordpress.com subdomain' do
      target = WpTarget.new('http://test.example.com/')
      target.wordpress_hosted?.should be_false
    end
  end

  describe '#redirection' do
    it 'returns nil if no redirection detected' do
      stub_request(:get, wp_target.url).to_return(status: 200, body: '')

      wp_target.redirection.should be_nil
    end

    [301, 302].each do |status_code|
      it "returns http://new-location.com if the status code is #{status_code}" do
        new_location = 'http://new-location.com'

        stub_request(:get, wp_target.url).
          to_return(status: status_code, headers: { location: new_location })

        stub_request(:get, new_location).to_return(status: 200)

        wp_target.redirection.should === 'http://new-location.com'
      end
    end

    context 'when multiple redirections' do
      it 'returns the last redirection' do
        first_redirection  = 'www.redirection.com'
        last_redirection   = 'redirection.com'

        stub_request(:get, wp_target.url).to_return(status: 301, headers: { location: first_redirection })
        stub_request(:get, first_redirection).to_return(status: 302, headers: { location: last_redirection })
        stub_request(:get, last_redirection).to_return(status: 200)

        wp_target.redirection.should === last_redirection
      end
    end
  end

  describe '#debug_log_url' do
    it "returns 'http://example.localhost/wp-content/debug.log" do
      wp_target.stub(wp_content_dir: 'wp-content')
      wp_target.debug_log_url.should === 'http://example.localhost/wp-content/debug.log'
    end
  end

  describe '#has_debug_log?' do
    let(:fixtures_dir) { SPEC_FIXTURES_WPSCAN_WP_TARGET_DIR + '/debug_log' }

    after :each do
      wp_target.stub(wp_content_dir: 'wp-content')
      stub_request_to_fixture(url: wp_target.debug_log_url(), fixture: @fixture)
      wp_target.has_debug_log?.should === @expected
    end

    it 'returns false' do
      @fixture  = SPEC_FIXTURES_DIR + '/empty-file'
      @expected = false
    end

    it 'returns true' do
      @fixture  = fixtures_dir + '/debug.log'
      @expected = true
    end

    it 'should also detect it if there are PHP notice' do
      @fixture  = fixtures_dir + '/debug-notice.log'
      @expected = true
    end
  end

  describe '#search_replace_db_2_url' do
    it 'returns the correct url' do
      wp_target.search_replace_db_2_url.should == 'http://example.localhost/searchreplacedb2.php'
    end
  end

  describe '#search_replace_db_2_exists?' do
    it 'returns true' do
      stub_request(:any, wp_target.search_replace_db_2_url).to_return(status: 200, body: 'asdf by interconnect asdf')
      wp_target.search_replace_db_2_exists?.should be_true
    end

    it 'returns false' do
      stub_request(:any, wp_target.search_replace_db_2_url).to_return(status: 500)
      wp_target.search_replace_db_2_exists?.should be_false
    end

    it 'returns false' do
      stub_request(:any, wp_target.search_replace_db_2_url).to_return(status: 500, body: 'asdf by interconnect asdf')
      wp_target.search_replace_db_2_exists?.should be_false
    end
  end

end
