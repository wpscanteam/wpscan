# frozen_string_literal: true

describe OptParseValidator::OptCredentials do
  subject(:opt) { described_class.new(['-l', '--login USERNAME:PASSWORD']) }

  describe '#validate' do
    context 'when incorrect format' do
      it 'raises an error' do
        expect { opt.validate('wrong') }
          .to raise_error(OptParseValidator::Error, 'Incorrect credentials format, username:password expected')
      end
    end

    context 'when valid format' do
      it 'returns a hash with :username and :password' do
        expect(opt.validate('admin:P@ssw:rd'))
          .to eq(username: 'admin', password: 'P@ssw:rd')
      end
    end
  end
end
