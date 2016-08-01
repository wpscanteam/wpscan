# encoding: UTF-8

require 'spec_helper'
require WPSCAN_LIB_DIR + '/wp_target'

describe 'WpTimthumbs::Detectable' do
  subject(:wp_timthumbs)   { WpTimthumbs }
  let(:fixtures_dir)       { COLLECTIONS_FIXTURES + '/wp_timthumbs/detectable' }
  let(:targets_items_file) { fixtures_dir + '/targets.txt' }
  let(:wp_content_dir)     { 'wp-content' }
  let(:wp_plugins_dir)     { wp_content_dir + '/plugins' }
  let(:wp_target)          { WpTarget.new(url, wp_content_dir: wp_content_dir, wp_plugins_dir: wp_plugins_dir) }
  let(:url)                { 'http://example.com/' }
  let(:uri)                { URI.parse(url) }
  let(:empty_file)         { SPEC_FIXTURES_DIR + '/empty-file' }

  let(:expected) do
    {
      targets_from_file: [WpTimthumb.new(uri, path: 'timthumb.php'),
                          WpTimthumb.new(uri, path: '$wp-content$/timthumb.php'),
                          WpTimthumb.new(uri, path: '$wp-plugins$/a-gallery/timthumb.php'),
                          WpTimthumb.new(uri, path: '$wp-content$/themes/theme-name/timthumb.php')]

    }
  end

  def expected_targets_from_theme(theme_name)
    expected = []
    %w(
      timthumb.php lib/timthumb.php inc/timthumb.php includes/timthumb.php
      scripts/timthumb.php tools/timthumb.php functions/timthumb.php thumb.php
    ).each do |file|
      path = "$wp-content$/themes/#{theme_name}/#{file}"
      expected << WpTimthumb.new(uri, path: path)
    end
    expected
  end

  describe '::passive_detection' do
    it 'returns an empty WpTimthumbs' do
      expect(subject.passive_detection(wp_target)).to eq subject.new
    end
  end

  describe '::targets_items_from_file' do
    after do
      targets = subject.send(:targets_items_from_file, file, wp_target)

      expect(targets.map(&:url)).to eq @expected.map(&:url)
    end

    context 'when an empty file' do
      let(:file) { empty_file }

      it 'returns an empty Array' do
        @expected = []
      end
    end

    context 'when a non empty file' do
      let(:file) { targets_items_file }

      it 'returns the correct Array of WpTimthumb' do
        @expected = expected[:targets_from_file]
      end
    end
  end

  describe '::theme_timthumbs' do
    it 'returns the correct Array of WpTimthumb' do
      theme   = 'hello-world'
      targets = subject.send(:theme_timthumbs, theme, wp_target)

      expect(targets.map(&:url)).to eq expected_targets_from_theme(theme).map(&:url)
    end
  end

  describe '::targets_items' do
    let(:options) { {} }

    after do
      targets = subject.send(:targets_items, wp_target, options)

      expect(targets.map(&:url)).to match_array(@expected.map(&:url))
    end

    context 'when no :theme_name' do
      context 'when no :file' do
        it 'returns an empty Array' do
          @expected = []
        end
      end

      context 'when :file' do
        let(:options) { { file: targets_items_file } }

        it 'returns the targets from the file' do
          @expected = expected[:targets_from_file]
        end
      end
    end

    context 'when :theme_name' do
      let(:theme) { 'theme-name' }

      context 'when no :file' do
        let(:options) { { theme_name: theme } }

        it 'returns targets from the theme' do
          @expected = expected_targets_from_theme(theme)
        end
      end

      context 'when :file' do
        let(:options) { { theme_name: theme, file: targets_items_file } }

        it 'returns merged targets from theme and file' do
          @expected = (expected_targets_from_theme('theme-name') + expected[:targets_from_file]).uniq { |i| i.url }
        end
      end
    end
  end
end
