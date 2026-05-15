# frozen_string_literal: true

describe WPScan::Finders::Users::LoginErrorMessages do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://wp.lab/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('users', 'login_error_messages') }

  describe '#aggressive' do
    let(:opts) { { found: [], list: %w[admin editor invalid] } }
    let(:valid_error_body) do
      '<html><body><div id="login_error">' \
        'The password you entered for the username admin is incorrect.' \
        '</div></body></html>'
    end
    let(:invalid_error_body) { '<html><body><div id="login_error">Invalid username.</div></body></html>' }
    let(:no_error_body) { '<html><body></body></html>' }

    before do
      allow(target).to receive(:do_login).with('admin', anything)
                                         .and_return(Typhoeus::Response.new(body: valid_error_body))
      allow(target).to receive(:do_login).with('editor', anything)
                                         .and_return(Typhoeus::Response.new(body: valid_error_body.gsub('admin',
                                                                                                        'editor')))
      allow(target).to receive(:do_login).with('invalid', anything)
                                         .and_return(Typhoeus::Response.new(body: invalid_error_body))
    end

    it 'returns valid usernames as User objects' do
      users = finder.aggressive(opts)

      expect(users.size).to eq 2
      expect(users[0]).to be_a WPScan::Model::User
      expect(users[0].username).to eq 'admin'
      expect(users[0].confidence).to eq 100
      expect(users[0].found_by).to match(/Login Error Messages/)

      expect(users[1].username).to eq 'editor'
    end

    context 'when error message is empty' do
      before do
        allow(target).to receive(:do_login).with('admin', anything)
                                           .and_return(Typhoeus::Response.new(body: no_error_body))
      end

      it 'returns empty array and stops checking' do
        expect(finder.aggressive(opts)).to eql []
      end
    end
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
