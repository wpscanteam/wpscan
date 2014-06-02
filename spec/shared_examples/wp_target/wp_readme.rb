# encoding: UTF-8

shared_examples 'WpTarget::WpReadme' do

  let(:fixtures_dir) { SPEC_FIXTURES_WPSCAN_WP_TARGET_DIR + '/wp_readme' }

  describe '#readme_url' do
    it 'returns http://example.localhost/readme.html' do
      expect(wp_target.readme_url).to be === "#{wp_target.uri}readme.html"
    end
  end

  describe '#has_readme?' do
    after do
      stub_request(:get, wp_target.readme_url).to_return(@stub)

      expect(wp_target.has_readme?).to be === @expected
    end

    it 'returns false on a 404' do
      @stub     = { status: 404 }
      @expected = false
    end

    it 'returns true if it exists' do
      @stub     = { status: 200, body: File.new(fixtures_dir + '/readme-3.2.1.html') }
      @expected = true
    end

    it 'returns true even if the readme.html is not in english' do
      @stub     = { status: 200, body: File.new(fixtures_dir + '/readme-3.3.2-fr.html') }
      @expected = true
    end
  end

end
