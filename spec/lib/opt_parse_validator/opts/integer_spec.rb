# frozen_string_literal: true

describe OptParseValidator::OptInteger do
  subject(:opt) { described_class.new(['-i', '--int INT']) }

  describe '#validate' do
    context 'when not an integer' do
      it 'raises an error' do
        expect { opt.validate('a') }.to raise_error(OptParseValidator::Error, 'a is not an integer')
      end
    end

    it 'returns the integer' do
      expect(opt.validate('12')).to eq 12
    end
  end
end
