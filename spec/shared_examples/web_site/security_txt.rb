# encoding: UTF-8

shared_examples 'WebSite::SecurityTxt' do
  let(:known_dirs) { WebSite::SecurityTxt.known_dirs }

  describe '#security_url' do
    it 'returns the correct url' do
      expect(web_site.security_url).to eql 'http://example.localhost/security.txt'
    end
  end

  describe '#has_security?' do
    it 'returns true' do
      stub_request(:get, web_site.security_url).to_return(status: 200)
      expect(web_site.has_security?).to be_truthy
    end

    it 'returns false' do
      stub_request(:get, web_site.security_url).to_return(status: 404)
      expect(web_site.has_security?).to be_falsey
    end
  end

  describe '#parse_security_txt' do

    context 'installed in root' do
      after :each do
        stub_request_to_fixture(url: web_site.security_url, fixture: @fixture)
        security = web_site.parse_security_txt
        expect(security).to match_array @expected
      end

      it 'returns an empty Array (empty security.txt)' do
        @fixture = fixtures_dir + '/security_txt/empty_security.txt'
        @expected = []
      end

      it 'returns an empty Array (invalid security.txt)' do
        @fixture = fixtures_dir + '/security_txt/invalid_security.txt'
        @expected = []
      end

      it 'returns some urls and some strings' do
        @fixture = fixtures_dir + '/security_txt/invalid_security_2.txt'
        @expected = %w(
          /ÖÜ()=?
          http://10.0.0.0/wp-includes/
          http://example.localhost/asdf/
          wooooza
        )
      end

      it 'returns an Array of urls (valid security.txt)' do
        @fixture = fixtures_dir + '/security_txt/security.txt'
        @expected = %w(
          http://example.localhost/wordpress/admin/
          http://example.localhost/wordpress/wp-admin/
          http://example.localhost/wordpress/secret/
          http://example.localhost/Wordpress/wp-admin/
          http://example.localhost/wp-admin/tralling-space/
          http://example.localhost/asdf/
        )
      end

      it 'removes duplicate entries from security.txt test 1' do
        @fixture = fixtures_dir + '/security_txt/security_duplicate_1.txt'
        @expected = %w(
          http://example.localhost/wordpress/
          http://example.localhost/wordpress/admin/
          http://example.localhost/wordpress/wp-admin/
          http://example.localhost/wordpress/secret/
          http://example.localhost/Wordpress/wp-admin/
          http://example.localhost/wp-admin/tralling-space/
          http://example.localhost/asdf/
        )
      end

      it 'removes duplicate entries from security.txt test 2' do
        @fixture = fixtures_dir + '/security_txt/security_duplicate_2.txt'
        @expected = nil
      end
    end

    context 'installed in sub directory' do
      it 'returns an Array of urls (valid security.txt, WP installed in subdir)' do
        web_site_sub = WebSite.new('http://example.localhost/wordpress/')
        fixture = fixtures_dir + '/security_txt/security.txt'
        expected = %w(
            http://example.localhost/wordpress/admin/
            http://example.localhost/wordpress/secret/
            http://example.localhost/Wordpress/wp-admin/
            http://example.localhost/wp-admin/tralling-space/
            http://example.localhost/asdf/
          )
        stub_request_to_fixture(url: web_site_sub.security_url, fixture: fixture)
        security = web_site_sub.parse_security_txt
        expect(security).to match_array expected
      end
    end
  end

  describe '#known_dirs' do
    it 'does not contain duplicates' do
      expect(known_dirs.flatten.uniq.length).to eq known_dirs.length
    end
  end

end
