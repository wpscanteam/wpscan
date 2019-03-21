# frozen_string_literal: true

describe WPScan::Finders::Users::LoginErrorMessages do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://wp.lab/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('users', 'login_error_messages') }

  describe '#aggressive' do
    xit
  end

  describe '#usernames' do
    let(:opts) { { found: [] } }

    after { expect(subject.usernames(opts)).to eql @expected }

    context 'when no :list provided' do
      it 'returns an empty list' do
        @expected = []
      end
    end

    context 'when :list provided' do
      let(:opts) { super().merge(list: %w[u1 u2]) }

      it 'returns the expected array' do
        @expected = opts[:list]
      end
    end
  end
end
