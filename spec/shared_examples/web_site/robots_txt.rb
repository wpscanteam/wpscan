# encoding: UTF-8

shared_examples 'WebSite::RobotsTxt' do
  let(:known_dirs) { WebSite::RobotsTxt.known_dirs }

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

  describe '#parse_robots_txt' do

    context 'installed in root' do
      after :each do
        stub_request_to_fixture(url: web_site.robots_url, fixture: @fixture)
        robots = web_site.parse_robots_txt
        robots.should =~ @expected
      end

      it 'returns an empty Array (empty robots.txt)' do
        @fixture = fixtures_dir + '/robots_txt/empty_robots.txt'
        @expected = []
      end

      it 'returns an empty Array (invalid robots.txt)' do
        @fixture = fixtures_dir + '/robots_txt/invalid_robots.txt'
        @expected = []
      end

      it 'returns an Array of urls (valid robots.txt)' do
        @fixture = fixtures_dir + '/robots_txt/robots.txt'
        @expected = %w(
          http://example.localhost/wordpress/admin/
          http://example.localhost/wordpress/wp-admin/
          http://example.localhost/wordpress/secret/
          http://example.localhost/Wordpress/wp-admin/
          http://example.localhost/asdf/
        )
      end
    end

    context 'installed in sub directory' do
      it 'returns an Array of urls (valid robots.txt, WP installed in subdir)' do
        web_site_sub = WebSite.new('http://example.localhost/wordpress/')
        fixture = fixtures_dir + '/robots_txt/robots.txt'
        expected = %w(
            http://example.localhost/wordpress/admin/
            http://example.localhost/wordpress/secret/
            http://example.localhost/Wordpress/wp-admin/
            http://example.localhost/asdf/
          )
        stub_request_to_fixture(url: web_site_sub.robots_url, fixture: fixture)
        robots = web_site_sub.parse_robots_txt
        robots.should =~ expected
      end
    end
  end

  describe '#known_dirs' do
    it 'does not contain duplicates' do
      known_dirs.flatten.uniq.length.should == known_dirs.length
    end
  end

end
