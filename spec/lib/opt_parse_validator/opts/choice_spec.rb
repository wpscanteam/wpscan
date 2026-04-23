# frozen_string_literal: true

describe OptParseValidator::OptChoice do
  subject(:opt) { described_class.new(option, attrs) }
  let(:option)  { ['-f', '--format FORMAT'] }
  let(:attrs)   { { choices: %w[json cli] } }

  describe '#new' do
    context 'when errors' do
      after { expect { opt }.to raise_error(*@exception) }

      context 'when :choices not provided' do
        let(:attrs) { {} }

        it 'raises an error' do
          @exception = OptParseValidator::Error, 'The :choices attribute is mandatory'
        end
      end

      context 'when :choices is not an array' do
        let(:attrs) { { choices: 'wrong type' } }

        it 'raises an error' do
          @exception = OptParseValidator::Error, 'The :choices attribute must be an array'
        end
      end
    end

    context 'when valid' do
      it 'sets the option correctly' do
        expect { opt }.to_not raise_error
        expect(opt.attrs[:choices]).to eq attrs[:choices]
      end
    end
  end

  describe '#append_help_messages' do
    context 'when no default attribute' do
      its(:help_messages) { should eql ["Available choices: #{attrs[:choices].join(', ')}"] }
    end

    context 'when a default attribute' do
      let(:attrs) { super().merge(default: 'cli') }

      its(:help_messages) { should eql ['Default: cli', 'Available choices: json, cli'] }

      context 'when the default is not given as a string' do
        let(:attrs) { super().merge(normalize: :to_sym, default: :json) }

        its(:help_messages) { should eql ['Default: json', 'Available choices: json, cli'] }
      end
    end
  end

  describe '#validate' do
    after :each do
      if @exception
        expect { opt.validate(@value) }.to raise_error(*@exception)
      else
        expect(opt.validate(@value)).to eq(@expected)
      end
    end

    context 'when the value is not in the choices' do
      it 'raises an error' do
        @value     = 'invalid-format'
        @exception = OptParseValidator::Error,
                     "'invalid-format' is not a valid choice, expected one of the followings: json,cli"
      end

      context 'when :case_sensitive' do
        let(:attrs) { { choices: %w[json cli], case_sensitive: true } }

        it 'raises an error' do
          @value     = 'JSON'
          @exception = OptParseValidator::Error,
                       "'JSON' is not a valid choice, expected one of the followings: json,cli"
        end
      end
    end

    context 'when valid choice' do
      it 'returns the choice' do
        @value    = 'JSON'
        @expected = 'json'
      end

      context 'when :case_sensitive' do
        let(:attrs) { { choices: %w[JSON cli], case_sensitive: true } }

        it 'raises an error' do
          @value    = 'JSON'
          @expected = 'JSON'
        end
      end
    end
  end
end
