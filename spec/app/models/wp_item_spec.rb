# frozen_string_literal: true

describe WPScan::Model::WpItem do
  subject(:wp_item)  { described_class.new(slug, blog, opts) }
  let(:slug)         { 'test_item' }
  let(:blog)         { WPScan::Target.new(url) }
  let(:url)          { 'http://wp.lab/' }
  let(:opts)         { {} }

  its(:blog) { should eql blog }

  describe '#new' do
    context 'when no opts' do
      its(:slug) { should eql slug }
      its(:detection_opts) { should eql(mode: nil) }
      its(:version_detection_opts) { should eql({}) }
    end

    context 'when :mode' do
      let(:opts) { super().merge(mode: :passive, version_detection: { mode: :aggressive }) }

      its(:detection_opts) { should eql(mode: :passive) }
      its(:version_detection_opts) { should eql(mode: :aggressive) }
    end

    context 'when the slug contains encoded chars' do
      let(:slug) { 'theme%212%23a' }

      its(:slug) { should eql 'theme!2#a' }
    end
  end

  describe '#url' do
    context 'when no opts[:url]' do
      its(:url) { should eql nil }
    end

    context 'when opts[:url]' do
      let(:opts) { super().merge(url: item_url) }
      let(:item_url) { "#{url}item/" }

      context 'when path given' do
        it 'appends it' do
          expect(wp_item.url('path')).to eql "#{item_url}path"
        end
      end

      it 'encodes the path' do
        expect(wp_item.url('#t#')).to eql "#{item_url}#t%23"
        expect(wp_item.url('t .txt')).to eql "#{item_url}t%20.txt"
      end
    end
  end

  describe '#==' do
    context 'when the same slug' do
      it 'returns true' do
        other = described_class.new(slug, blog)

        expect(wp_item == other).to be true
      end
    end

    context 'when another object' do
      it 'returns false' do
        expect(wp_item == 'string').to be false
      end
    end

    context 'when different slugs' do
      it 'returns false' do
        other = described_class.new('another', blog)

        expect(wp_item == other).to be false
      end
    end
  end

  describe '#latest_version' do
    # Handled in plugin_spec / theme_spec
  end

  describe '#popular?' do
    # Handled in plugin_spec / theme_spec
  end

  describe '#last_updated' do
    # Handled in plugin_spec / theme_spec
  end

  describe '#outdated?' do
    # Handled in plugin_spec / theme_spec
  end

  describe '#to_s' do
    its(:to_s) { should eql slug }
  end

  describe '#classify' do
    its(:classify) { should eql :TestItem }

    context 'when it starts with a digit' do
      let(:slug) { '2test' }

      its(:classify) { should eql :D_2test }

      context 'when a digit and -' do
        let(:slug) { '23-test' }

        its(:classify) { should eql :D_23Test }
      end
    end
  end

  # Guess all the below should be in the theme/plugin specs
  describe '#readme_url' do
    let(:opts) { super().merge(url: item_url) }
    let(:item_url) { "#{url}wp-content/plugins/test_item/" }

    context 'when detection mode is :passive' do
      let(:opts) { super().merge(mode: :passive) }

      it 'returns nil without making requests' do
        expect(WPScan::Browser).not_to receive(:forge_request)
        expect(wp_item.readme_url).to be_nil
      end
    end

    context 'when detection mode is not :passive' do
      before do
        allow(blog).to receive(:head_or_get_params).and_return({})
      end

      context 'when a readme file is found' do
        it 'returns the readme URL' do
          # First readme attempt (readme.txt) returns 404
          stub_request(:get, "#{item_url}readme.txt").to_return(status: 404)
          # Second readme attempt (README.txt) returns 200
          stub_request(:get, "#{item_url}README.txt").to_return(status: 200)

          expect(wp_item.readme_url).to eq "#{item_url}README.txt"
        end

        it 'caches the result' do
          stub_request(:get, "#{item_url}readme.txt").to_return(status: 200)

          # First call makes the request
          expect(wp_item.readme_url).to eq "#{item_url}readme.txt"
          # Second call should use cached value
          expect(wp_item.readme_url).to eq "#{item_url}readme.txt"
        end
      end

      context 'when no readme file is found' do
        it 'returns false' do
          # Stub all potential readme filenames to return 404
          WPScan::Model::WpItem::READMES.each do |readme|
            stub_request(:get, "#{item_url}#{readme}").to_return(status: 404)
          end

          expect(wp_item.readme_url).to be false
        end
      end
    end
  end

  describe '#directory_listing?' do
    xit
  end

  describe '#error_log?' do
    xit
  end

  describe '#head_and_get' do
    let(:opts) { super().merge(url: item_url) }
    let(:item_url) { "#{url}wp-content/plugins/test_item/" }
    let(:path_from_blog) { 'wp-content/plugins/test_item/' }

    before do
      # Set @path_from_blog as Plugin/Theme classes do in their initialize
      wp_item.instance_variable_set(:@path_from_blog, path_from_blog)
    end

    it 'prepends @path_from_blog to the path and delegates to blog.head_and_get' do
      expect(blog).to receive(:head_and_get).with('wp-content/plugins/test_item/readme.txt', [200], {})
      wp_item.head_and_get('readme.txt', [200], {})
    end

    it 'handles nil path by using only @path_from_blog' do
      expect(blog).to receive(:head_and_get).with('wp-content/plugins/test_item/', [200], {})
      wp_item.head_and_get(nil, [200], {})
    end

    it 'passes custom codes and params to blog.head_and_get' do
      custom_params = { head: { timeout: 5 }, get: { timeout: 10 } }
      expect(blog).to receive(:head_and_get).with('wp-content/plugins/test_item/style.css', [200, 404], custom_params)
      wp_item.head_and_get('style.css', [200, 404], custom_params)
    end
  end

  describe '#active_installs' do
    context 'when wordpress_org_api_url is nil' do
      it 'returns nil and does not make a request' do
        expect(WPScan::Browser).not_to receive(:get)
        expect(wp_item.active_installs).to be_nil
      end
    end

    context 'when wordpress_org_api_url is set' do
      let(:api_url) { 'https://api.wordpress.org/plugins/info/1.2/?action=plugin_information&request[slug]=test_item' }

      before { allow(wp_item).to receive(:wordpress_org_api_url).and_return(api_url) }

      context 'on a successful response' do
        before do
          stub_request(:get, api_url).to_return(
            status: 200,
            body: { 'active_installs' => 1234, 'last_updated' => '2024-01-15 10:30am GMT' }.to_json
          )
        end

        it 'returns the active_installs value' do
          expect(wp_item.active_installs).to eql 1234
        end

        it 'shares a single HTTP call with API-sourced last_updated' do
          allow(wp_item).to receive(:metadata).and_return({})
          expect(WPScan::Browser).to receive(:get).once.and_call_original
          expect(wp_item.active_installs).to eql 1234
          expect(wp_item.last_updated).to eql '2024-01-15 10:30am GMT'
        end
      end

      context 'on a non-200 response' do
        before { stub_request(:get, api_url).to_return(status: 404, body: '') }

        it 'returns nil' do
          expect(wp_item.active_installs).to be_nil
        end
      end

      context 'on invalid JSON' do
        before { stub_request(:get, api_url).to_return(status: 200, body: 'not json') }

        it 'returns nil' do
          expect(wp_item.active_installs).to be_nil
        end
      end

      context 'when active_installs key is absent' do
        before { stub_request(:get, api_url).to_return(status: 200, body: '{}') }

        it 'returns nil' do
          expect(wp_item.active_installs).to be_nil
        end
      end
    end
  end

  describe '#last_updated source precedence' do
    before do
      allow(wp_item).to receive(:metadata).and_return('last_updated' => '2020-01-01T00:00:00.000Z')
      allow(wp_item).to receive(:wordpress_org_data).and_return(api_response)
    end

    context 'when wordpress.org returns a value' do
      let(:api_response) { { 'last_updated' => '2026-04-14 12:01pm GMT' } }

      it 'prefers the wordpress.org value over the DB metadata' do
        expect(wp_item.last_updated).to eql '2026-04-14 12:01pm GMT'
        expect(wp_item.last_updated_source).to eql 'WordPress.org'
      end
    end

    context 'when wordpress.org has no value' do
      let(:api_response) { {} }

      it 'falls back to the DB metadata' do
        expect(wp_item.last_updated).to eql '2020-01-01T00:00:00.000Z'
        expect(wp_item.last_updated_source).to eql 'db'
      end
    end
  end

  describe '#last_updated_iso, #last_updated_display' do
    before { allow(wp_item).to receive(:last_updated).and_return(value) }

    context 'with an ISO 8601 string from the local DB' do
      let(:value) { '2015-05-16T00:00:00.000Z' }

      its(:last_updated_iso)     { should eql '2015-05-16T00:00:00Z' }
      its(:last_updated_display) { should eql '2015-05-16 12:00am GMT' }
    end

    context 'with the wordpress.org API string' do
      let(:value) { '2026-04-14 12:01pm GMT' }

      its(:last_updated_iso)     { should eql '2026-04-14T12:01:00Z' }
      its(:last_updated_display) { should eql '2026-04-14 12:01pm GMT' }
    end

    context 'when the value cannot be parsed' do
      let(:value) { 'not a date' }

      its(:last_updated_iso)     { should be_nil }
      its(:last_updated_display) { should eql 'not a date' }
    end

    context 'when nil' do
      let(:value) { nil }

      its(:last_updated_iso)     { should be_nil }
      its(:last_updated_display) { should be_nil }
    end
  end

  describe '#last_updated_relative' do
    let(:now) { Time.utc(2026, 5, 8, 12, 0, 0) }

    before { allow(Time).to receive(:now).and_return(now) }

    {
      nil => nil,
      '' => nil,
      'not a date' => nil,
      '2026-05-08 11:59:30 UTC' => 'just now',
      '2026-05-08 11:55:00 UTC' => '5 minutes ago',
      '2026-05-08 11:00:00 UTC' => '1 hour ago',
      '2026-05-08 09:00:00 UTC' => '3 hours ago',
      '2026-05-07 12:00:00 UTC' => '1 day ago',
      '2026-05-01 12:00:00 UTC' => '7 days ago',
      '2026-02-08 12:00:00 UTC' => '2 months ago',
      '2024-05-08 12:00:00 UTC' => '2 years ago',
      '2027-05-08 12:00:00 UTC' => 'in the future'
    }.each do |input, expected|
      context "when last_updated is #{input.inspect}" do
        before { allow(wp_item).to receive(:last_updated).and_return(input) }

        it "returns #{expected.inspect}" do
          expect(wp_item.last_updated_relative).to eql expected
        end
      end
    end
  end
end
