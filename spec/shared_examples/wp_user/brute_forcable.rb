# encoding: UTF-8

shared_examples 'WpUser::BruteForcable' do
  let(:fixtures_dir)  { MODELS_FIXTURES + '/wp_user/brute_forcable' }
  let(:wordlist_iso)  { fixtures_dir + '/wordlist-iso-8859-1.txt' }
  let(:wordlist_utf8) { fixtures_dir + '/wordlist-utf-8.txt' }
  let(:mod)           { WpUser::BruteForcable }

  before { Browser.instance.max_threads = 1 }

  describe '::passwords_from_wordlist' do
    let(:expected)  { %w{password1 pa55w0rd #comment admin root} << ' spaceafterandbefore ' }
    let(:exception) { 'Invalid wordlist, expected String or Array' }

    after do
      if @expected
        mod.passwords_from_wordlist(wordlist).should == @expected
      else
        expect { mod.passwords_from_wordlist(wordlist) }.to raise_error(@exception)
      end
    end

    context 'when the wordlist is a file' do
      context 'when encoded with ISO-8859-1' do
        let(:wordlist) { wordlist_iso }

        it 'returns the expected passwords' do
          @expected = expected << "kansei\xA3\xD4"
        end
      end

      context 'when encoded with UTF-8' do
        let(:wordlist) { wordlist_utf8 }

        it 'returns the expected passwords' do
          @expected = expected << 'kansei£Ô'
        end
      end
    end

    context 'when the wordlist is an Array<String>' do
      let(:wordlist) { %w{hello pwet yolo} }

      it 'returns it' do
        @expected = wordlist
      end
    end

    context 'when the wordlist is invalid' do
      let(:wordlist) { 200 }

      it 'raises an error' do
        @exception = exception
      end
    end
  end

  describe '#valid_password?' do
    let(:response)     { Typhoeus::Response.new(resp_options) }
    let(:resp_options) { {} }
    let(:return_to)    { 'http://www.example.com/asdf/' }

    after do
      wp_user.valid_password?(response, 'password', return_to).should == @expected
    end

    context 'when 302 and valid return_to parameter' do
      let(:resp_options) { { code: 302, headers: { 'Location' => return_to } } }

      it 'returns true' do
        @expected = true
      end
    end

    context 'when 302 and invalid return_to parameter' do
      let(:resp_options) { { code: 302, headers: { 'Location' => nil } } }

      it 'returns false' do
        @expected = false
      end
    end

    context 'when login_error' do
      let(:resp_options) { { body: '<div id="login_error">' } }

      it 'returns false' do
        @expected = false
      end
    end

    context 'when timeout' do
      let(:resp_options) { { return_code: :operation_timedout } }

      it 'returns false' do
        @expected = false
      end
    end

    context 'when no response from server (status = 0)' do
      let(:resp_options) { { code: 0 } }

      it 'returns false' do
        @expected = false
      end
    end

    context 'when error 50x' do
      let(:resp_options) { { code: 500 } }

      it 'returns false' do
        @expected = false
      end
    end

    context 'when unknown response' do
      let(:resp_options) { { code: 202 } }

      it 'returns false' do
        @expected = false
      end
    end
  end

  # TODO
  describe '#login_request' do

  end

  describe '#brute_force' do
    let(:passwords)     { %w{pass1 pass2 yolo kansei£Ô} }
    let(:login)         { 'someuser' }
    let(:redirect_url)  { 'http://www.example.com/asdf/' }

    after do
      wp_user.login = login
      wp_user.brute_force(passwords, {}, redirect_url)
      wp_user.password.should == @expected
    end

    context 'when no password is valid' do
      before do
        stub_request(:post, wp_user.login_url).
          #with(body: { log: login }). # produces an error : undefined method `split' for {:log=>"someuser", :pwd=>"password1"}:Hash
          to_return(body: 'login_error')
      end

      it 'does not set @password' do
        @expected = nil
      end
    end

    context 'when a password is valid' do
      # Due to the error with .with(body: { log: login }) above
      # We can't use it to stub the request for a specific password
      # So, the first one will be valid
      before { stub_request(:post, wp_user.login_url).to_return(status: 302, headers: { 'Location' => redirect_url } ) }

      it 'sets the @password' do
        @expected = passwords[0]
      end
    end
  end

end
