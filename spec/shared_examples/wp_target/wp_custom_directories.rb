# encoding: UTF-8

shared_examples 'WpTarget::WpCustomDirectories' do

  describe '#wp_content_dir' do
    let(:fixtures_dir) { SPEC_FIXTURES_WPSCAN_WP_TARGET_DIR + '/wp_content_dir' }

    after :each do
      @wp_target = WpTarget.new(@target_url) if @target_url

      stub_request_to_fixture(url: @wp_target.url, fixture: @fixture) if @fixture
      stub_request(:get, /.*\/wp-content\/?$/).to_return(:status => 200, :body => '') # default dir request
      stub_request(:get, /.*\.html$/).to_return(:status => 200, :body => '') # 404 hash request

      expect(@wp_target.wp_content_dir).to be === @expected
    end

    it 'returns the string set in the initialize method' do
      @wp_target = WpTarget.new('http://example.localhost/', options.merge(wp_content_dir: 'hello-world'))
      @expected  = 'hello-world'
    end

    it "returns 'wp-content'" do
      @target_url = 'http://lamp/wordpress-3.4.1'
      @fixture    = fixtures_dir + '/wordpress-3.4.1.htm'
      @expected   = 'wp-content'
    end

    it "returns 'wp-content' if url has trailing slash" do
      @target_url = 'http://lamp/wordpress-3.4.1/'
      @fixture    = fixtures_dir + '/wordpress-3.4.1.htm'
      @expected   = 'wp-content'
    end

    it "should find the default 'wp-content' dir even if the target_url is not the same (ie : the user supply an IP address and the url used in the code is a domain)" do
      @target_url = 'http://192.168.1.103/wordpress-3.4.1/'
      @fixture    = fixtures_dir + '/wordpress-3.4.1.htm'
      @expected   = 'wp-content'
    end

    it "returns 'custom-content'" do
      @target_url = 'http://lamp/wordpress-3.4.1-custom'
      @fixture    = fixtures_dir + '/wordpress-3.4.1-custom.htm'
      @expected   = 'custom-content'
    end

    it "returns 'custom content spaces'" do
      @target_url = 'http://lamp/wordpress-3.4.1-custom'
      @fixture    = fixtures_dir + '/wordpress-3.4.1-custom-with-spaces.htm'
      @expected   = 'custom content spaces'
    end

    it "returns 'custom-dir/subdir/content'" do
      @target_url = 'http://lamp/wordpress-3.4.1-custom'
      @fixture    = fixtures_dir + '/wordpress-3.4.1-custom-subdirectories.htm'
      @expected   = 'custom-dir/subdir/content'
    end

    it 'should also check in src attributes' do
      @target_url = 'http://lamp/wordpress-3.4.1'
      @fixture    = fixtures_dir + '/wordpress-3.4.1-in-src.htm'
      @expected   = 'wp-content'
    end

    it 'should find the location even if the src or href goes in the plugins dir' do
      @target_url = 'http://wordpress-3.4.1-in-plugins.htm'
      @fixture    = fixtures_dir + '/wordpress-3.4.1-in-plugins.htm'
      @expected   = 'wp-content'
    end

    it 'should not detect facebook.com as a custom wp-content directory' do
      @target_url = 'http://lamp.localhost/'
      @fixture    = fixtures_dir + '/facebook-detection.htm'
      @expected   = nil
    end
  end

  describe '#default_wp_content_dir_exists?' do
    after :each do
      @wp_target = WpTarget.new('http://lamp.localhost/')
      stub_request(:get, @wp_target.url).to_return(:status => 200, :body => 'homepage') # homepage request

      expect(@wp_target.default_wp_content_dir_exists?).to be === @expected
    end

    it 'returns false if wp-content returns an invalid response code' do
      stub_request(:get, /.*\/wp-content\/?$/).to_return(:status => 404, :body => '') # default dir request
      stub_request(:get, /.*\.html$/).to_return(:status => 404, :body => '') # 404 hash request
      @expected   = false
    end

     it 'returns false if wp-content and homepage have same bodies' do
      stub_request(:get, /.*\/wp-content\/?$/).to_return(:status => 200, :body => 'homepage') # default dir request
      stub_request(:get, /.*\.html$/).to_return(:status => 404, :body => '404!') # 404 hash request
      @expected   = false
    end

    it 'returns false if wp-content and 404 page have same bodies' do
      stub_request(:get, /.*\/wp-content\/?$/).to_return(:status => 200, :body => '404!') # default dir request
      stub_request(:get, /.*\.html$/).to_return(:status => 404, :body => '404!') # 404 hash request
      @expected   = false
    end

     it 'returns true if wp-content, 404 page and hoempage return different bodies' do
      stub_request(:get, /.*\/wp-content\/?$/).to_return(:status => 200, :body => '') # default dir request
      stub_request(:get, /.*\.html$/).to_return(:status => 200, :body => '404!') # 404 hash request
      @expected   = true
    end
  end

  describe '#wp_plugins_dir' do
    after :each do
      expect(@wp_target.wp_plugins_dir).to be === @expected
    end

    it 'returns the string set in the initialize method' do
      @wp_target = WpTarget.new('http://example.localhost/', options.merge(wp_content_dir: 'asdf', wp_plugins_dir: 'custom-plugins'))
      @expected  = 'custom-plugins'
    end

    it "returns 'custom/plugins'" do
      @wp_target = WpTarget.new('http://example.localhost/', options.merge(wp_content_dir: 'custom', wp_plugins_dir: nil))
      @expected  = 'custom/plugins'
    end
  end

  describe '#wp_plugins_dir_exists?' do
    let(:wp_target)      { WpTarget.new('http://example.localhost/', custom_options) }
    let(:custom_options) { options.merge(wp_content_dir: 'asdf', wp_plugins_dir: 'custom-plugins') }
    let(:url)            { wp_target.uri.merge(wp_target.wp_plugins_dir).to_s }

    it 'returns true' do
      stub_request(:get, url).to_return(status: 200)
      expect(wp_target.wp_plugins_dir_exists?).to eq true
    end

    it 'returns false' do
      stub_request(:get, url).to_return(status: 404)
      expect(wp_target.wp_plugins_dir_exists?).to eq false
    end
  end

end
