# encoding: UTF-8

shared_examples_for 'BruteForce' do
  before :each do
    @module             = WpScanModuleSpec.new('http://example.localhost')
    @target_url         = @module.uri.to_s
    @fixtures_dir       = SPEC_FIXTURES_WPSCAN_MODULES_DIR + '/bruteforce'
    @wordlist           = @fixtures_dir + '/wordlist.txt'
    @username           = 'admin'

    @module.extend(BruteForce)
    Browser.instance.max_threads = 1
  end

  describe '#lines_in_file' do
    it 'should return 6' do
      lines = BruteForce.lines_in_file(@wordlist)
      lines.should == 6
    end
  end

  describe '#brute_force' do
    before :each do

    end

    it 'should get the correct password' do
      passwords = []
      File.open(@wordlist, 'r').each do |password|
        # ignore comments
        passwords << password.strip unless password.strip[0, 1] == '#'
      end
      # Last status must be 302 to get full code coverage
      passwords.each do |password|
        stub_request(:post, @module.login_url).
          to_return(
            { status: 200, body: 'login_error' },
            { status: 0,   body: 'no reponse' },
            { status: 500, body: 'server error' },
            { status: 999, body: 'invalid' },
            { status: 302, body: 'FOUND!' }
          )
      end

      user   = WpUser.new(@module.uri, login: 'admin')
      result = @module.brute_force([user], @wordlist)

      result.length.should == 1
      result.should === [{ name: 'admin', password: 'root' }]
    end

    it 'should cover the timeout branch and return an empty array' do
      stub_request(:post, @module.login_url).to_timeout

      user          = WpUser.new(@module.uri, login: 'admin')
      result        = @module.brute_force([user], @wordlist)
      result.should == []
    end
  end
end
