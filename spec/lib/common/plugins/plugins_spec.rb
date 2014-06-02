# encoding: UTF-8

require 'spec_helper'

class TestPlugin < Plugin
  def initialize
    register_options(['-u', '--url'])
  end
end

class AnotherPlugin < Plugin
  def initialize
    super(author: 'John')
    # No Options
  end
end

describe Plugins do
  subject(:plugins) { Plugins.new }

  let(:test_plugin) { TestPlugin.new }
  let(:another_plugin) { AnotherPlugin.new }

  describe '#new' do
    context 'without argument' do
      its(:option_parser) { is_expected.to be_a CustomOptionParser }

      it 'should be an Array' do
        expect(plugins).to be_an Array
      end
    end

    context 'with an option_parser argument' do
      subject(:plugin) { Plugins.new(CustomOptionParser.new('the banner')) }

      its(:option_parser) { is_expected.to be_a CustomOptionParser }
      its('option_parser.banner') { is_expected.to be === 'the banner' }

      it 'should raise an eror if the parser is not an instance of CustomOptionParser' do
        expect { Plugins.new(OptionParser.new) }.to raise_error('The parser must be an instance of CustomOptionParser, OptionParser supplied')
      end
    end
  end

  describe '#register_plugin' do
    after :each do
      if @exception
        expect { plugins.register_plugin(@plugin) }.to raise_error(@exception)
      else
        plugins.register_plugin(@plugin)
        expect(plugins).to include(@plugin)
        expect(plugins).to be === @expected
      end
    end

    context 'when the argument supplied is not an instance of Plugin' do
      it 'should raise an error' do
        @plugin    = "I'am a String"
        @exception = 'The argument must be an instance of Plugin, String supplied'
      end
    end

    it 'should register the plugin' do
      @plugin = TestPlugin.new
      @expected = [@plugin]
    end

    it 'should register 2 plugins (the order is important)' do
      plugins.register_plugin(test_plugin)

      @plugin   = another_plugin
      @expected = [test_plugin, @plugin]
    end
  end

  describe '#register' do
    after :each do
      plugins.register(*@plugins_to_register)

      @plugins_to_register.each do |plugin|
        expect(plugins).to include(plugin)
      end

      # For the correct order
      expect(plugins).to be === @plugins_to_register
    end

    it 'should register 1 plugin' do
      @plugins_to_register = [test_plugin]
    end

    it 'should register 2 plugins' do
      @plugins_to_register = [another_plugin, test_plugin]
    end
  end

end
