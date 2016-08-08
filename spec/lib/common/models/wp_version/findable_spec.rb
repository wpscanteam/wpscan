# encoding: UTF-8

require 'spec_helper'

describe 'WpVersion::Findable' do
  let(:fixtures_dir)  { MODELS_FIXTURES + '/wp_version/findable/' }
  let(:uri)           { URI.parse('http://example.com/') }
  let(:generator_urls) {
    {
      rss_generator: uri.merge('feed/').to_s,
      rdf_generator: uri.merge('feed/rdf/').to_s,
      atom_generator: uri.merge('feed/atom/').to_s,
      comments_rss_generator: uri.merge('comments/feed/').to_s,
      sitemap_generator: uri.merge('sitemap.xml').to_s
    }
  }

  # Dynamic creation for all generator methods
  WpVersion.methods.grep(/^find_from_.*_generator$/).each do |method|
    dir_name = method.to_s[%r{^find_from_(.*)$}, 1]

    describe "::#{method}" do
      let(:url) { generator_urls[dir_name.to_sym] || uri.to_s }

      after do
        fixture = fixtures_dir + dir_name + @fixture
        stub_request_to_fixture(url: url, fixture: fixture)

        expect(WpVersion.send(method, uri)).to eq @expected
      end

      context 'when generator not found' do
        it 'returns nil' do
          @fixture = '/no_generator.html'
          @expected = nil
        end
      end

      context 'when version not found' do
        it 'returns nil' do
          @fixture  = '/no_version.html'
          @expected = nil
        end
      end

      context 'when invalid version' do
        it 'returns nil' do
          @fixture  = '/invalid_version.html'
          @expected = nil
        end
      end

      it 'returns 3.3.2' do
        @fixture  = '/3.3.2.html'
        @expected = '3.3.2'
      end

      it 'returns 3.4-beta4' do
        @fixture  = '/3.4-beta4.html'
        @expected = '3.4-beta4'
      end

      if method == :find_from_meta_generator
        it 'returns 3.5' do
          @fixture  = '/3.5_minified.html'
          @expected = '3.5'
        end

        it 'returns 3.5.1' do
          @fixture  = '/3.5.1_mobile.html'
          @expected = '3.5.1'
        end
      end

    end
  end

  describe '::find_from_advanced_fingerprinting' do
    let(:fixture_dir)    { fixtures_dir + 'advanced_fingerprinting/' }
    let(:wp_content_dir) { 'wp-content' }
    let(:wp_plugins_dir) { wp_content_dir + '/plugins' }
    let(:versions_xml)   { fixture_dir + 'wp_versions.xml' }

    after do
      version = WpVersion.send(
        :find_from_advanced_fingerprinting,
        uri, wp_content_dir, wp_plugins_dir, versions_xml
      )
      expect(version).to eq @expected
    end

    context 'when' do
      it 'returns nil' do
        stub_request(:get, /.*/).to_return(status: 404, body: '')
        @expected = nil
      end
    end

    it 'returns 3.2.1' do
      stub_request_to_fixture(
        url: uri.merge('wp-admin/js/wp-fullscreen.js').to_s,
        fixture: fixture_dir + '3.2.1.js'
      )

      @expected = '3.2.1'
    end
  end

  describe '::find_from_readme' do
    let(:url) { uri.merge('readme.html').to_s }

    after do
      fixture = fixtures_dir + 'readme' + @fixture
      stub_request_to_fixture(url: url, fixture: fixture)

      expect(WpVersion.send(:find_from_readme, uri)).to eq @expected
    end

    context 'when version not found' do
      it 'returns nil' do
        @fixture  = '/empty_version.html'
        @expected = nil
      end
    end

    context 'when invalid version' do
      it 'returns nil' do
        @fixture  = '/invalid_version.html'
        @expected = nil
      end
    end

    it 'returns 3.3.2' do
      @fixture  = '/3.3.2.html'
      @expected = '3.3.2'
    end
  end

  describe '::find_from_links_opml' do
    let(:url) { uri.merge('wp-links-opml.php') }

    after do
      fixture = fixtures_dir + 'links_opml' + @fixture
      stub_request_to_fixture(url: url, fixture: fixture)

      expect(WpVersion.send(:find_from_links_opml, uri)).to eq @expected
    end

    it 'returns 3.4.2' do
      @fixture  = '/3.4.2.xml'
      @expected = '3.4.2'
    end

    context 'when no generator' do
      it 'returns nil' do
        @fixture = '/no_generator.xml'
        @expected = nil
      end
    end
  end

  describe '::find_from_stylesheets_numbers' do
    after do
      fixture = fixtures_dir + 'stylesheet_numbers' + @fixture
      stub_request_to_fixture(url: uri, fixture: fixture)

      expect(WpVersion.send(:find_from_stylesheets_numbers, uri)).to eq @expected
    end

    context 'invalid url' do
      it 'returns nil' do
        @fixture = '/invalid_url.html'
        @expected = nil
      end
    end
  end

  describe '::find' do
    # Stub all WpVersion::find_from_* to return nil
    def stub_all_to_nil
      WpVersion.methods.grep(/^find_from_/).each do |method|
        allow(WpVersion).to receive(method).and_return(nil)
      end
    end

    let(:wp_content_dir) { 'wp-content' }
    let(:wp_plugins_dir) { wp_content_dir + '/plugins' }
    let(:version_xml)    {}

    after do
      stub_request(:get, /#{uri.to_s}.*/).to_return(status: 0)

      version = WpVersion.find(uri, wp_content_dir, wp_plugins_dir, version_xml)
      expect(version).to eq @expected
      if @expected
        expect(version.found_from).to eq @found_from
      end
    end

    context 'when no version found' do
      it 'returns nil' do
        stub_all_to_nil
        @expected = nil
      end
    end

    WpVersion.methods.grep(/^find_from_/).each do |method|
      number     = "#{rand(5)}.#{rand(3)}"
      found_from = method[/^find_from_(.*)/, 1].sub('_', ' ')

      context "when found from #{found_from}" do
        it 'returns the correct WpVersion' do
          stub_all_to_nil

          allow(WpVersion).to receive(method).and_return(number)

          @expected = WpVersion.new(uri, number: number)
          @found_from = found_from
        end
      end
    end

  end

end
