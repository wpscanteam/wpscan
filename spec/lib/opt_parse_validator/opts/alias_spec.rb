# frozen_string_literal: true

describe OptParseValidator::OptAlias do
  subject(:opt) { described_class.new(option, attrs) }
  let(:option)  { %w[-a --alias] }
  let(:attrs)   { { alias_for: '--test -e' } }

  describe '#initialise, #alias_for' do
    context 'when no :alias_for attrs' do
      let(:attrs) { {} }

      it 'raises an error' do
        expect { opt }.to raise_error 'The :alias_for attribute is required'
      end
    end

    context 'when :alias_for attrs' do
      it 'sets it' do
        expect(opt.alias_for).to eql attrs[:alias_for]
      end
    end
  end

  describe '#alias?' do
    its(:alias?) { should be true }
  end

  describe '#help_messages' do
    it 'contains the message related to the alias' do
      expect(opt.help_messages).to include("Alias for #{attrs[:alias_for]}")
    end
  end
end
