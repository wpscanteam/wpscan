# encoding: UTF-8

require File.expand_path(File.join(__dir__, 'wpscan_helper'))

describe WpTarget do
  subject(:wp_target) { WpTarget.new(target_url, options) }
  subject(:wp_target_custom) { WpTarget.new(target_url, options_custom) }
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
  let(:options_custom)       {
    {
      config_file:    SPEC_FIXTURES_CONF_DIR + '/browser.conf.json',
      cache_ttl:      0,
      wp_content_dir: 'custom-content',
      wp_plugins_dir: 'custom-content/plugins'
    }
  }

  before { Browser::reset }

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

      expect(wp_target.login_url).to be === login_url
    end

    it 'returns the redirection url if there is one (ie: for https)' do
      https_login_url = login_url.gsub(/^http:/, 'https:')

      stub_request(:get, login_url).to_return(status: 302, headers: { location: https_login_url })
      stub_request(:get, https_login_url).to_return(status: 200)

      expect(wp_target.login_url).to be === https_login_url
    end
  end

  describe '#wordpress?' do
    # each url (wp-login and xmlrpc) pointed to a 404
    before :each do
      stub_request(:get, wp_target.url).
        to_return(status: 200, body: '', headers: { 'X-Pingback' => wp_target.uri.merge('xmlrpc.php')})

      # Preventing redirection check from login_url()
      allow(wp_target).to receive_messages(redirection: nil)

      [wp_target.login_url, wp_target.xml_rpc_url].each do |url|
        stub_request(:get, url).to_return(status: 404, body: '')
      end
    end

    it 'returns true if there is a /wp-content/ detected in the index page source' do
      stub_request_to_fixture(url: wp_target.url, fixture: fixtures_dir + '/wp_content_dir/wordpress-3.4.1.htm')

      expect(wp_target).to be_wordpress
    end

    it 'returns true if a custom content directory is detected' do
      stub_request_to_fixture(url: wp_target_custom.url, fixture: fixtures_dir + '/wp_content_dir/wordpress-3.4.1-custom.htm')
      expect(wp_target_custom).to be_wordpress
    end

    it 'returns true if the xmlrpc is found' do
      stub_request(:get, wp_target.xml_rpc_url).
        to_return(status: 200, body: File.new(fixtures_dir + '/xmlrpc.php'))

      expect(wp_target).to be_wordpress
    end

    it 'returns true if the wp-login is found and is a valid wordpress one' do
      stub_request(:get, wp_target.login_url).
        to_return(status: 200, body: File.new(fixtures_dir + '/wp-login.php'))

      expect(wp_target).to be_wordpress
    end

    it 'returns false if both files are not found (404)' do
      expect(wp_target).not_to be_wordpress
    end

    context 'when the url contains "wordpress" and is a 404' do
      let(:target_url) { 'http://lamp/wordpress-3.5./' }

      it 'returns false' do
        stub_request(:get, wp_target.login_url).to_return(status: 404, body: 'The requested URL /wordpress-3.5. was not found on this server.')

        expect(wp_target).not_to be_wordpress
      end
    end

    context 'when the response is a 403' do
      before { stub_request(:any, /.*/).to_return(status: 403) }

      it 'raises an error' do
        expect { wp_target.wordpress? }.to raise_error
      end
    end
  end

  describe '#wordpress_hosted?' do
    it 'returns true if target url is a wordpress.com subdomain' do
      target = WpTarget.new('http://test.wordpress.com/')
      expect(target.wordpress_hosted?).to be_truthy
    end

    it 'returns true if target url is a wordpress.com subdomain and has querystring' do
      target = WpTarget.new('http://test.wordpress.com/path/file.php?a=b')
      expect(target.wordpress_hosted?).to be_truthy
    end

    it 'returns false if target url is not a wordpress.com subdomain' do
      target = WpTarget.new('http://test.example.com/')
      expect(target.wordpress_hosted?).to be_falsey
    end
  end

  describe '#debug_log_url' do
    it "returns 'http://example.localhost/wp-content/debug.log" do
      allow(wp_target).to receive_messages(wp_content_dir: 'wp-content')
      expect(wp_target.debug_log_url).to be === 'http://example.localhost/wp-content/debug.log'
    end
  end

  describe '#has_debug_log?' do
    let(:fixtures_dir) { SPEC_FIXTURES_WPSCAN_WP_TARGET_DIR + '/debug_log' }

    after :each do
      allow(wp_target).to receive_messages(wp_content_dir: 'wp-content')
      stub_request_to_fixture(url: wp_target.debug_log_url, fixture: @fixture)
      expect(wp_target.has_debug_log?).to be === @expected
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
      expect(wp_target.search_replace_db_2_url).to eq 'http://example.localhost/searchreplacedb2.php'
    end
  end

  describe '#search_replace_db_2_exists?' do
    it 'returns true' do
      stub_request(:any, wp_target.search_replace_db_2_url).to_return(status: 200, body: 'asdf by interconnect asdf')
      expect(wp_target.search_replace_db_2_exists?).to be_truthy
    end

    it 'returns false' do
      stub_request(:any, wp_target.search_replace_db_2_url).to_return(status: 500)
      expect(wp_target.search_replace_db_2_exists?).to be_falsey
    end

    it 'returns false' do
      stub_request(:any, wp_target.search_replace_db_2_url).to_return(status: 500, body: 'asdf by interconnect asdf')
      expect(wp_target.search_replace_db_2_exists?).to be_falsey
    end
  end

  describe '#emergency_url' do
    it 'returns the correct url' do
      expect(wp_target.emergency_url).to eq 'http://example.localhost/emergency.php'
    end
  end

  describe '#emergency_exists?' do
    it 'returns true' do
      stub_request(:any, wp_target.emergency_url).to_return(status: 200, body: 'enter your password here')
      expect(wp_target.emergency_exists?).to be_truthy
    end

    it 'returns false' do
      stub_request(:any, wp_target.emergency_url).to_return(status: 500)
      expect(wp_target.emergency_exists?).to be_falsey
    end

    it 'returns false' do
      stub_request(:any, wp_target.emergency_url).to_return(status: 500, body: 'enter your password here')
      expect(wp_target.emergency_exists?).to be_falsey
    end
  end

end
