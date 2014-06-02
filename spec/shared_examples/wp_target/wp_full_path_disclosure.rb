# encoding: UTF-8

shared_examples 'WpTarget::WpFullPathDisclosure' do

  let(:fixtures_dir) { SPEC_FIXTURES_WPSCAN_WP_TARGET_DIR + '/wp_full_path_disclosure' }

  describe '#full_path_disclosure_url' do
    it 'returns http://example.localhost/wp-includes/rss-functions.php' do
      expect(wp_target.full_path_disclosure_url).to be === 'http://example.localhost/wp-includes/rss-functions.php'
    end
  end

  describe '#has_full_path_disclosure?' do
    after do
      stub_request(:get, wp_target.full_path_disclosure_url).
        to_return(@stub)

      expect(wp_target.has_full_path_disclosure?).to be === @expected
    end

    it 'returns false on a 404' do
      @stub     = { status: 404 }
      @expected = false
    end

    it 'returns false if no fpd found (blank page for example)' do
      @stub     = { status: 200, body: '' }
      @expected = false
    end

    it 'returns true' do
      @stub     = { status: 200, body: File.new(fixtures_dir + '/rss-functions-disclosure.php') }
      @expected = true
    end
  end

end
