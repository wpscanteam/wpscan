# frozen_string_literal: true

describe OptParseValidator::OptPositiveInteger do
  subject(:opt) { described_class.new(['-i', '--int INT']) }

  describe '#validate' do
    context 'when not > 0' do
      it 'raises an error' do
        expect { opt.validate('-3') }.to raise_error(OptParseValidator::Error, '-3 is not > 0')
      end
    end

    it 'returns the integer' do
      expect(opt.validate('20')).to eq 20
    end
  end
end
