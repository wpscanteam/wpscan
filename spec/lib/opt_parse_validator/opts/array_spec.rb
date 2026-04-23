# frozen_string_literal: true

describe OptParseValidator::OptArray do
  subject(:opt) { described_class.new(['-a', '--array VALUES'], attrs) }
  let(:attrs)   { {} }

  describe '#append_help_messages' do
    context 'when default separator' do
      its(:help_messages) { should eql ["Separator to use between the values: ','"] }
    end

    context 'when custom separator' do
      let(:attrs) { super().merge(separator: '-') }

      its(:help_messages) { should eql ["Separator to use between the values: '-'"] }
    end
  end

  describe '#validate' do
    context 'when an empty or nil value is given' do
      context 'when no value_if_empty attribute' do
        it 'raises an error' do
          [nil, ''].each do |value|
            expect { opt.validate(value) }.to raise_error(OptParseValidator::Error, 'Empty option value supplied')
          end
        end
      end

      context 'when value_if_empty attribute' do
        let(:attrs) { super().merge(value_if_empty: 'a,b') }

        it 'returns the expected array' do
          [nil, ''].each do |value|
            expect(opt.validate(value)).to eql %w[a b]
          end
        end
      end
    end

    context 'when the separator is not supplied' do
      context 'when not present in the argument' do
        it 'returns an array with the correct value' do
          expect(opt.validate('rspec')).to eql %w[rspec]
        end
      end

      context 'when present' do
        it 'returns the expected array' do
          expect(opt.validate('r1,r2,r3')).to eql %w[r1 r2 r3]
        end
      end
    end

    context 'when separator supplied' do
      subject(:opt) { described_class.new(['-a', '--array VALUES'], separator: '-') }

      it 'returns an array with the correct value' do
        expect(opt.validate('r1,r2,r3')).to eql %w[r1,r2,r3]
      end

      it 'returns the expected array' do
        expect(opt.validate('r1-r2-r3')).to eql %w[r1 r2 r3]
      end
    end
  end

  describe '#normalize' do
    after { expect(opt.normalize(@value)).to eql @expected }

    context 'when no :normalize attribute' do
      it 'returns the value' do
        @value    = %w[t1 t2]
        @expected = @value
      end
    end

    context 'when a single normalization' do
      let(:attrs) { { normalize: :to_sym } }

      it 'returns the expected value' do
        @value    = [1.0, 'test']
        @expected = [1.0, :test]
      end
    end
  end
end
