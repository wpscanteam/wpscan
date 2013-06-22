# encoding: UTF-8

require 'spec_helper'

describe 'common_helper' do
  describe '#get_equal_string' do
    after :each do
      output = get_equal_string_end(@input)

      output.should == @expected
    end

    it 'returns an empty string' do
      @input    = %w()
      @expected = ''
    end

    it 'returns an empty string' do
      @input    = []
      @expected = ''
    end

    it 'returns an empty string' do
      @input    = ['asdf', nil]
      @expected = ''
    end

    it 'returns an empty string' do
      @input    = [nil, 'asdf']
      @expected = ''
    end

    it 'returns asdf' do
      @input    = [nil, 'a asdf', nil, 'b asdf']
      @expected = ' asdf'
    end

    it 'returns asdf' do
      @input    = ['kjh asdf', 'oijr asdf']
      @expected = ' asdf'
    end

    it 'returns &laquo;  BlogName' do
      @input = ['user1 &laquo;  BlogName',
                'user2 &laquo;  BlogName',
                'user3 &laquo;  BlogName',
                'user4 &laquo;  BlogName']
      @expected = ' &laquo;  BlogName'
    end

    it 'returns an empty string' do
      @input    = %w{user1 user2 user3 user4}
      @expected = ''
    end

    it 'returns an empty string' do
      @input = ['user1 &laquo;  BlogName',
                'user2 &laquo;  BlogName',
                'user3 &laquo;  BlogName',
                'user4 &laquo;  BlogNamea']
      @expected = ''
    end

    it 'returns an empty string' do
      @input    = %w{ user1 }
      @expected = ''
    end

    it 'returns | test' do
      @input    = ['admin | test', 'test | test']
      @expected = ' | test'
    end
  end
end