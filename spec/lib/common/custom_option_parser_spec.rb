# encoding: UTF-8

require 'spec_helper'

describe CustomOptionParser do

  let(:parser) { CustomOptionParser.new }

  describe '#new' do

  end

  describe '::option_to_symbol' do
    after :each do
      if @exception
        expect { CustomOptionParser::option_to_symbol(@option) }.to raise_error(@exception)
      else
        expect(CustomOptionParser::option_to_symbol(@option)).to be === @expected
      end
    end

    context 'without REQUIRED or OPTIONAL arguments' do
      context 'with short option' do
        it 'should return :test' do
          @option   = ['-t', '--test', 'Testing']
          @expected = :test
        end

        it 'should :its_a_long_option' do
          @option   = ['-l', '--its-a-long-option', "Testing '-' replacement"]
          @expected = :its_a_long_option
        end
      end

      context 'without short option' do
        it 'should return :long' do
          @option   = ['--long', "The method should find the option name ('long')"]
          @expected = :long
        end

        it 'should return :long_option' do
          @option   = ['--long-option', 'No short !']
          @expected = :long_option
        end
      end

      context 'without long option' do
        it 'should raise an arror' do
          @option    = ['-v', 'The long option is missing there']
          @exception = 'Could not find the option name for ["-v", "The long option is missing there"]'
        end

        it 'should raise an error' do
          @option    = ['The long option is missing there']
          @exception =  'Could not find the option name for ["The long option is missing there"]'
        end
      end

      context 'with multiple long option names (like alias)' do
        it 'should return :check_long and not :cl' do
          @option   = ['--check-long', '--cl']
          @expected = :check_long
        end
      end
    end

    context 'with REQUIRED or OPTIONAL arguments' do
      it 'should removed the OPTIONAL argument' do
        @option   = ['-p', '--page [PAGE_NUMBER]']
        @expected = :page
      end

      it 'should removed the REQUIRED argument' do
        @option   = ['--url TARGET_URL']
        @expected = :url
      end
    end

  end

  describe '#add_option' do
    context 'exception throwing if' do
      after :each do
        expect { parser.add_option(@option) }.to raise_error(@exception)
      end

      it 'argument passed is not an Array' do
        @option    = 'a simple String'
        @exception = "The option must be an array, String supplied : 'a simple String'"
      end

      it 'option name is already used' do
        @option    = ['-v', '--verbose', 'Verbose mode']
        parser.add_option(@option)
        @exception = 'The option verbose is already used !'
      end
    end

    it 'should have had 2 symbols (:verbose, :url) to @symbols_used' do
      parser.add_option(['-v', '--verbose'])
      parser.add_option(['--url TARGET_URL'])

      expect(parser.symbols_used.sort).to be === [:url, :verbose]
    end

    context 'parsing' do
      before :each do
        parser.add_option(['-u', '--url TARGET_URL', 'Set the target url'])
      end

      it 'should raise an error if an unknown option is supplied' do
        expect { parser.parse!(['--verbose']) }.to raise_error(OptionParser::InvalidOption)
      end

      it 'should raise an error if an option require an argument which is not supplied' do
        expect { parser.parse!(['--url']) }.to raise_error(OptionParser::MissingArgument)
      end

      it 'should retrieve the correct argument' do
        parser.parse!(['-u', 'iam_the_target'])
        expect(parser.results).to be === { url: 'iam_the_target' }
      end
    end
  end

  describe '#add' do
    it 'should raise an error if the argument is not an Array or Array(Array)' do
      expect { parser.add('Hello') }.to raise_error('Options must be at least an Array, or an Array(Array). String supplied')
    end

    before :each do
      parser.add(['-u', '--url TARGET_URL'])
    end

    context 'single option' do
      it 'should add the :url option, and retrieve the correct argument' do
        expect(parser.symbols_used).to be === [:url]
        expect(parser.results(['-u', 'target.com'])).to be === { url: 'target.com' }
      end
    end

    context 'multiple options' do
      it 'should add 2 options, and retrieve the correct arguments' do
        parser.add([
          ['-v', '--verbose'],
          ['--test [TEST_NUMBER]']
        ])

        expect(parser.symbols_used.sort).to be === [:test, :url, :verbose]
        expect(parser.results(['-u', 'wp.com', '-v', '--test'])).to be === { test: nil, url: 'wp.com', verbose: true }
      end
    end
  end

end
