# encoding: UTF-8

shared_examples 'WpTarget::BruteForce' do

  let(:fixtures_dir) { SPEC_FIXTURES_WPSCAN_WP_TARGET_DIR + '/bruteforce' }
  let(:wordlist)     { fixtures_dir + '/wordlist.txt' }

  before :each do
    wp_target.stub(:login_url).and_return('http://example.localhost/wp-login.php')

    Browser.instance.max_threads = 1
  end

  describe '#lines_in_file' do
    it 'returns 6' do
      lines = WpTarget::BruteForce.lines_in_file(wordlist)
      lines.should == 6
    end
  end

  describe '#brute_force' do

    it 'gets the correct password' do
      passwords = []
      File.open(wordlist, 'r').each do |password|
        # ignore comments
        passwords << password.strip unless password.strip[0, 1] == '#'
      end
      # Last status must be 302 to get full code coverage
      passwords.each do |password|
        stub_request(:post, wp_target.login_url).
          to_return(
            { status: 200, body: 'login_error' },
            { status: 0,   body: 'no reponse' },
            { status: 500, body: 'server error' },
            { status: 999, body: 'invalid' },
            { status: 302, body: 'FOUND!' }
          )
      end

      user   = WpUser.new(wp_target.uri, login: 'admin')
      result = wp_target.brute_force([user], wordlist)

      result.length.should == 1
      result.should === [{ name: 'admin', password: 'root' }]
    end

    it 'covers the timeout branch and return an empty array' do
      stub_request(:post, wp_target.login_url).to_timeout

      user          = WpUser.new(wp_target.uri, login: 'admin')
      result        = wp_target.brute_force([user], wordlist)
      result.should == []
    end
  end

end
