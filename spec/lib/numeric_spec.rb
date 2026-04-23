# frozen_string_literal: true

describe Numeric do
  describe '#bytes_to_human' do
    context 'when positive' do
      it 'returns the expected value' do
        expect(100.bytes_to_human).to eql '100 B'
        expect(11_497_472.bytes_to_human).to eql '10.965 MB'
      end
    end

    context 'when negative' do
      it 'uses the absolute value' do
        expect(-11_497_472.bytes_to_human).to eql '10.965 MB'
      end
    end

    context 'when zero' do
      it 'returns zero' do
        expect(0.bytes_to_human).to eql '0 B'
      end
    end
  end
end
