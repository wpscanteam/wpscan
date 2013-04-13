# encoding: UTF-8

shared_examples 'WpUser::BruteForcable' do
  let(:fixtures_dir) { MODELS_FIXTURES + '/wp_user/brute_forcable' }
  let(:wordlist)     { fixtures_dir + '/wordlist-iso-8859-1.txt' }
  let(:mod)          { WpUser::BruteForcable }
  let(:login_url)    { uri.merge('wp-login.php').to_s }

  before { Browser.instance.max_threads = 1 }

  describe '::lines_in_file' do
    it 'returns 5 (1 line is a comment)' do
      lines = mod.lines_in_file(wordlist)
      lines.should == 5
    end
  end

  describe '#valid_password?' do
    let(:response) { Typhoeus::Response.new(resp_options) }
    let(:resp_options) { {} }

    after do
      wp_user.valid_password?(response, 'password').should == @expected
    end

    context 'when 302' do
      let(:resp_options) { { code: 302 } }

      it 'returns true' do
        @expected = true
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

  describe 'wordlist charset' do
    let(:expected) { %w{password1 pa55w0rd #comment admin root kansei£Ô} }

    %w{wordlist-iso-8859-1.txt wordlist-utf-8.txt}.each do |file|
      it 'contains the expected lines' do
        file    = fixtures_dir + '/' + file
        charset = File.charset(file)

        lines = []
        File.open(file, "r:#{charset}").each do |line|
          lines << line.encode!('UTF-8').strip!
        end

        lines.should == expected
      end
    end
  end

  describe '#brute_force' do
    let(:passwords) {
      passwords = []
      charset   = File.charset(wordlist)

      File.open(wordlist, "r:#{charset}").each do |line|
        line.encode!('UTF-8').strip!
        passwords << line unless line[0,1] == '#'
      end
      passwords
    }
    let(:login) { 'someuser' }

    after do
      wp_user.login = login
      wp_user.brute_force(wordlist)
      wp_user.password.should == @expected
    end

    context 'when no password is valid' do
      before do
        stub_request(:post, login_url).
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
      before { stub_request(:post, login_url).to_return(status: 302) }

      it 'sets the @password' do
        @expected = passwords[0]
      end
    end
  end

end
