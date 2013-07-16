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
        subject.send(:from_header, wp_target).should == subject.new
      end
    end

    context 'when headers' do
      let(:headers)  { { } }
      let(:expected) { subject.new(wp_target) }

      after :each do
        stub_request(:get, url).to_return(status: 200, headers: headers, body: '')
        subject.send(:from_header, wp_target).should == expected
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
    # TODO
  end

  describe '::passive_detection' do
    # TODO
  end
end
