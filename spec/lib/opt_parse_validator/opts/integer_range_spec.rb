# frozen_string_literal: true

describe OptParseValidator::OptIntegerRange do
  subject(:opt) { described_class.new(['--range RANGE'], attrs) }
  let(:attrs)   { {} }

  describe '#append_help_messages' do
    context 'when no value_if_empty attribute' do
      its(:help_messages) { should eql ["Range separator to use: '-'"] }
    end

    context 'when value_if_empty attribute' do
      let(:attrs) { super().merge(value_if_empty: '1-10') }

      its(:help_messages) do
        should eql [
          "Range separator to use: '-'",
          'Value if no argument supplied: 1-10'
        ]
      end
    end
  end

  describe '#validate' do
    context 'when incorrect number of ranges given' do
      it 'raises an error' do
        expect { opt.validate('1-2-3') }
          .to raise_error(OptParseValidator::Error, 'Incorrect number of ranges found: 3, should be 2')
      end
    end

    context 'when not an integer range' do
      it 'raises an error' do
        expect { opt.validate('a-e') }
          .to raise_error(OptParseValidator::Error, 'Argument is not a valid integer range')
      end
    end

    context 'when a valid range' do
      it 'returns the range' do
        expect(opt.validate('1-5')).to eql(1..5)
      end

      context 'when another separator' do
        let(:attrs) { super().merge(separator: ':') }

        it 'returns the range' do
          expect(opt.validate('0:10')).to eql(0..10)
        end
      end
    end

    context 'when nil or "" supplied' do
      context 'when no value_if_empty attribute' do
        it 'raises an error' do
          [nil, ''].each do |value|
            expect { opt.validate(value) }.to raise_error(OptParseValidator::Error, 'Empty option value supplied')
          end
        end
      end

      context 'when value_if_empty attribute' do
        let(:attrs) { super().merge(value_if_empty: '0-2') }

        it 'returns the value_if_empty value' do
          [nil, ''].each do |value|
            expect(opt.validate(value)).to eql(0..2)
          end
        end
      end
    end
  end
end
