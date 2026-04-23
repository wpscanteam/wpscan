# frozen_string_literal: true

describe OptParseValidator::OptRegexp do
  subject(:opt) { described_class.new(['-r', '--regexp STRING'], attrs) }
  let(:attrs)   { {} }

  describe '#validate' do
    context 'when an empty value' do
      it 'raises an error' do
        expect { opt.validate('') }.to raise_error(OptParseValidator::Error, 'Empty option value supplied')
      end
    end

    context 'when no options' do
      it 'returns a Regexp' do
        expect(opt.validate('some text')).to eql(/some text/)
      end
    end

    context 'when options' do
      let(:attrs) { { options: Regexp::IGNORECASE | Regexp::MULTILINE } }

      it 'returns the expected Regexp' do
        expect(opt.validate('text')).to eql(/text/im)
      end
    end
  end
end
