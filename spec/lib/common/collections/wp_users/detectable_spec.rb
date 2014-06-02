# encoding: UTF-8

require 'spec_helper'
require WPSCAN_LIB_DIR + '/wp_target'

describe 'WpUsers::Detectable' do
  subject(:wp_users)   { WpUsers }
  let(:wp_content_dir) { 'wp-content' }
  let(:wp_plugins_dir) { wp_content_dir + '/plugins' }
  let(:wp_target)      { WpTarget.new(url, wp_content_dir: wp_content_dir, wp_plugins_dir: wp_plugins_dir) }
  let(:url)            { 'http://example.com/' }
  let(:uri)            { URI.parse(url) }

  def create_from_range(range)
    result = []

    range.each do |current_id|
      result << WpUser.new(uri, id: current_id)
    end
    result
  end

  describe '::request_params' do
    it 'return an empty Hash' do
      expect(subject.request_params).to be === {}
    end
  end

  describe '::passive_detection' do
    it 'return an empty WpUsers' do
      expect(subject.passive_detection(wp_target)).to eq subject.new
    end
  end

  describe '::targets_items' do
    after do
      targets = subject.send(:targets_items, wp_target, options)

      expect(targets).to eq @expected
    end

    context 'when no :range' do
      let(:options) { {} }

      it 'returns Array<WpUser> with id from 1 to 10' do
        @expected = create_from_range((1..10))
      end
    end

    context 'when :range' do
      let(:options) { { range: (1..2) } }

      it 'returns Array<WpUser> with id from 1 to 2' do
        @expected = create_from_range((1..2))
      end
    end
  end

end
