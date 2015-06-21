# encoding: UTF-8

require 'spec_helper'

describe 'WpTheme::Findable' do
  let(:fixtures_dir) { MODELS_FIXTURES + '/wp_theme/findable' }
  let(:uri)          { URI.parse('http://example.com/') }

  describe '::find_from_css_link' do
    before do
      stub_request(:get, /.+\/style.css$/).to_return(status: 200)
    end

    after do
      @body ||= File.new(fixtures_dir + '/css_link/' + @file)
      stub_request(:get, uri.to_s).to_return(status: 200, body: @body)

      wp_theme = WpTheme.send(:find_from_css_link, uri)

      expect(wp_theme).to be_a WpTheme if @expected
      expect(wp_theme).to eq @expected
      expect(wp_theme.wp_content_dir).to eql 'wp-content' if @expected
    end

    context 'when theme is not present' do
      it 'returns nil' do
        @body     = ''
        @expected = nil
      end
    end

    context 'when the theme name has spaces or special chars' do
      it 'returns the WpTheme' do
        @file     = 'theme-name-with-spaces.html'
        @expected = WpTheme.new(uri, name: 'Copia di simplefolio')
      end
    end

    context 'when <link> is inline' do
      it 'returns the WpTheme' do
        @file     = 'inline_link_tag.html'
        @expected = WpTheme.new(uri, name: 'inline')
      end
    end

    # FIXME: the style_url should be checked in WpTheme for absolute / relative
    context 'when relative url is used' do
      it 'returns the WpTheme' do
        @file = 'relative_urls.html'
        @expected = WpTheme.new(uri, name: 'theme_name')
      end
    end

    context 'when other style.css is referenced' do
      it 'returns the WpTheme' do
        @file = 'yootheme.html'
        @expected = WpTheme.new(uri, name: 'yoo_solar_wp', referenced_url: '/wp-content/themes/yoo_solar_wp/styles/wood/css/style.css')
      end
    end

    # This one might introduce FP btw
    context 'when leaked from comments' do
      it 'returns the WpTheme' do
        @file = 'comments.html'
        @expected = WpTheme.new(uri, name: 'debug')
      end
    end
  end

  describe '::find_from_wooframework' do
    before do
      stub_request(:get, /.+\/style.css$/).to_return(status: 200)
    end

    after do
      @body ||= File.new(fixtures_dir + '/wooframework/' + @file)
      stub_request(:get, uri.to_s).to_return(status: 200, body: @body)

      wp_theme = WpTheme.send(:find_from_wooframework, uri)

      if @expected
        expect(wp_theme).to be_a WpTheme
      end
      expect(wp_theme).to eq @expected
    end

    context 'when theme is not present' do
      it 'returns nil' do
        @body     = ''
        @expected = nil
      end
    end

    it 'returns the WpTheme' do
      @file     = 'merchant-no-version.html'
      @expected = WpTheme.new(uri, name: 'Merchant')
    end

    context 'when the version is present' do
      it 'returns the WpTheme with it' do
        @file     = 'editorial-1.3.5.html'
        @expected = WpTheme.new(uri, name: 'Editorial', version: '1.3.5')
      end
    end
  end

  describe '::find' do
    # Stub all WpTheme::find_from_* to return nil
    def stub_all_to_nil
      WpTheme.methods.grep(/^find_from_/).each do |method|
        allow(WpTheme).to receive(method).and_return(nil)
      end
    end

    context 'when a method is named s_find_from_s' do
      it 'does not call it' do
        class WpTheme
          module Findable
            extend self
            def s_find_from_s(s); raise 'I should not be called by ::find' end
          end
        end

        stub_all_to_nil

        expect { WpTheme.find(uri) }.to_not raise_error
      end
    end

    context 'when the theme is not found' do
      it 'returns nil' do
        stub_all_to_nil

        expect(WpTheme.find(uri)).to be_nil
      end
    end

    context 'when the theme is found' do
      it 'returns it, with the :found_from set' do
        stub_all_to_nil
        stub_request(:get, /.+\/the-oracle\/style.css$/).to_return(status: 200)
        expected = WpTheme.new(uri, name: 'the-oracle')

        allow(WpTheme).to receive(:find_from_css_link).and_return(expected)
        wp_theme = WpTheme.find(uri)

        expect(wp_theme).to be_a WpTheme
        expect(wp_theme).to eq expected
        expect(wp_theme.found_from).to be === 'css link'
      end
    end

  end

end
