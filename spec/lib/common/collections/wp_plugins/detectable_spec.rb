# encoding: UTF-8

require 'spec_helper'
require WPSCAN_LIB_DIR + '/wp_target'

describe 'WpPlugins::Detectable' do
  subject(:wp_plugins)     { WpPlugins }
  let(:wp_content_dir)     { 'wp-content' }
  let(:wp_plugins_dir)     { wp_content_dir + '/plugins' }
  let(:wp_target)          { WpTarget.new(url, wp_content_dir: wp_content_dir, wp_plugins_dir: wp_plugins_dir) }
  let(:url)                { 'http://example.com/' }
  let(:uri)                { URI.parse(url) }

  describe '::from_header' do
    context 'when no header' do
      it 'returns an empty WpPlugins' do
        stub_request(:get, url).to_return(status: 200)
        expect(subject.send(:from_header, wp_target)).to eq subject.new
      end
    end

    context 'when headers' do
      let(:headers)  { { } }
      let(:expected) { subject.new(wp_target) }

      after :each do
        stub_request(:get, url).to_return(status: 200, headers: headers, body: '')
        expect(subject.send(:from_header, wp_target)).to eq expected
      end

      context 'when w3-total-cache detected' do
        it 'returns the w3-total-cache' do
          headers['X-Powered-BY'] = 'W3 Total Cache/0.9'
          expected.add('w3-total-cache', version: '0.9')
        end
      end

      context 'when wp-super-cache detected' do
        it 'returns the wp-super-cache' do
          headers['WP-Super-Cache'] = 'Served supercache file from PHP'
          expected.add('wp-super-cache')
        end
      end

      context 'when a header key with mutiple values' do
        let(:headers) { { 'X-Powered-BY' => ['PHP/5.4.9', 'ASP.NET'] } }

        context 'when no cache plugin' do
          it 'returns an empty WpPlugins' do
            # Handled
          end
        end

        context 'when a cache plugin' do
          it 'returns the correct plugin' do
            headers['X-Powered-BY'] << 'W3 Total Cache/0.9.2.5'

            expected.add('w3-total-cache', version: '0.9.2.5')
          end
        end
      end
    end
  end

  describe '::from_content' do
    context 'when no body' do
      it 'returns an empty WpPlugins' do
        stub_request(:get, url).to_return(status: 200, body: '')
        expect(subject.send(:from_content, wp_target)).to eq subject.new
      end
    end

    context 'when body' do
      @body = ''
      let(:expected) { subject.new(wp_target) }

      after :each do
        stub_request(:get, url).to_return(status: 200, body: @body)
        stub_request(:get, /readme\.txt/i).to_return(status: 404)
        expect(subject.send(:from_content, wp_target)).to eq expected
      end

      context 'when w3 total cache detected' do
        it 'returns the w3-total-cache' do
          @body = 'w3 total cache'
          expected.add('w3-total-cache')
        end
      end

      context 'when wp-super-cache detected' do
        it 'returns the wp-super-cache' do
          @body = 'wp-super-cache'
          expected.add('wp-super-cache')
        end
      end

      context 'when all-in-one-seo-pack detected' do
        it 'returns the all-in-one-seo-pack' do
          @body = '<!-- All in One SEO Pack 2.0.3.1 by Michael Torbert of Semper Fi Web Design[300,342] -->'
          expected.add('all-in-one-seo-pack', version: '2.0.3.1')
        end
      end

      context 'when google-universal-analytics detected' do
        it 'returns google-universal-analytics' do
          @body = '<!-- Google Universal Analytics for WordPress v2.4.2 -->'
          expected.add('google-universal-analytics', version: '2.4.2')
        end
      end
    end
  end

  describe '::passive_detection' do
    # TODO
  end
end
