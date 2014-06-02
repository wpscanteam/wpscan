# encoding: UTF-8

require 'spec_helper'

describe Plugin do
  subject(:plugin) { Plugin.new }

  describe '#new' do
    context 'with some infos' do
      subject(:plugin) { Plugin.new(infos) }
      let(:infos) { { author: 'John' } }

      its(:author) { is_expected.to be === infos[:author] }
    end
  end

  describe '#run' do
    it 'should raise a NotImplementedError' do
      expect { plugin.run }.to raise_error(NotImplementedError)
    end
  end

  describe '#register_options' do
    after :each do
      if @exception
        expect { plugin.register_options(*@options) }.to raise_error(@exception)
      else
        plugin.register_options(*@options)
        expect(plugin.registered_options.sort).to be === @expected.sort
      end
    end

    context 'when an option is not an Array' do
      it 'should raise an error' do
        @options   = [
          ['-v', '--verbose', 'It\'s a valid option'],
          'Not a valid one'
        ]
        @exception = 'Each option must be an array, String supplied'
      end
    end

    context 'when options are Arrays' do
      it 'should register the options' do
        @options  = [
          ['-v', '--verbose', 'Verbose mode'],
          ['-u', '--url TARGET_URL']
        ]
        @expected = *@options
      end
    end
  end

end
