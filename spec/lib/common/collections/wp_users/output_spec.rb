# encoding: UTF-8

require 'spec_helper'

describe 'WpUsers::Output' do
  subject(:wp_users)   { WpUsers.new(0) }
  let(:wp_content_dir) { 'wp-content' }
  let(:wp_plugins_dir) { wp_content_dir + '/plugins' }
  let(:wp_target)      { WpTarget.new(url, wp_content_dir: wp_content_dir, wp_plugins_dir: wp_plugins_dir) }
  let(:url)            { 'http://example.com/' }
  let(:uri)            { URI.parse(url) }

  describe '#remove_junk_from_display_names' do
    it 'does not throw an exception' do
      expect { subject.remove_junk_from_display_names }.to_not raise_error
    end
  end

  describe '#remove_junk_from_display_names' do
    before :each do
      @input = WpUsers.new(0)
    end

    after :each do
      subject.push(@input)
      subject.flatten!
      subject.remove_junk_from_display_names
      expect(subject).to be === @expected
    end

    it 'should return an empty array' do
      @expected = @input
    end

    it 'should return input object' do
      @input.push(WpUser.new(nil))
      @expected = @input
    end

    it 'should return input object' do
      @input.push(WpUser.new(''))
      @expected = @input
    end

    it 'should remove asdf' do
      @input.push(WpUser.new('', login: '', id: 1, display_name: 'lkjh asdf'))
      @input.push(WpUser.new('', login: '', id: 2, display_name: 'ijrjd asdf'))
      @expected = WpUsers.new(0)
      @expected.push(WpUser.new('', login: '', id: 1, display_name: 'lkjh'))
      @expected.push(WpUser.new('', login: '', id: 2, display_name: 'ijrjd'))
    end

    it 'should return unmodified input object' do
      @input.push(WpUser.new('', login: '', id: 1, display_name: 'lkjh asdfa'))
      @input.push(WpUser.new('', login: '', id: 2, display_name: 'ijrjd asdf'))
      @expected = @input
    end

    it 'should return input object' do
      @input.push(WpUser.new('', login: '', id: 1, display_name: 'lkjh asdf'))
      @expected = @input
    end

    it 'should return an empty display_name' do
      @input.push(WpUser.new('', login: '', id: 1, display_name: 'lkhj asdf'))
      @input.push(WpUser.new('', login: '', id: 2, display_name: 'lkhj asdf'))
      @expected = WpUsers.new(0)
      @expected.push(WpUser.new('', login: '', id: 1, display_name: ''))
      @expected.push(WpUser.new('', login: '', id: 2, display_name: ''))
    end
  end
end
