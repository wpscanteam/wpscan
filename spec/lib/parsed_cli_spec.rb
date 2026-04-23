# frozen_string_literal: true

describe WPScan::ParsedCli do
  subject(:parsed_cli) { described_class }
  let(:options)        { { key: 'value', cache_ttl: 10 } }

  describe '#options=' do
    it 'sets them, reset the Browser and pass them to it' do
      expect(WPScan::Browser.instance.cache_ttl).to eql nil # Not yet set

      parsed_cli.options = options
      expect(WPScan::Browser.instance.cache_ttl).to eql 10
    end

    context 'when the options are modified from the top after being passed' do
      it 'does not modify them' do
        parsed_cli.options = options

        options[:key3] = 'value3'

        expect(parsed_cli.options).to eql(key: 'value', cache_ttl: 10)
      end
    end

    context 'when passing nil' do
      it 'sets an empty hash' do
        parsed_cli.options = nil

        expect(parsed_cli.options).to eql({})
      end
    end
  end

  describe '.options, .verbose etc' do
    it 'has the correct values' do
      parsed_cli.options = options

      expect(parsed_cli.options).to eql options

      expect(parsed_cli.verbose?).to be false

      expect(parsed_cli.key).to eql 'value'
      expect(parsed_cli.cache_ttl).to eql 10

      expect(parsed_cli.nothing).to eql nil
    end
  end
end
