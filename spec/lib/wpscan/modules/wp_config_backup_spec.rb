shared_examples_for "WpConfigBackup" do

  before :all do
    @module              = WpScanModuleSpec.new('http://example.localhost')
    @fixtures_dir        = SPEC_FIXTURES_WPSCAN_MODULES_DIR + '/wp_config_backup'
    @config_backup_files = WpConfigBackup.config_backup_files

    @module.extend(WpConfigBackup)
  end

  describe "#config_backup" do

    # set all @config_backup_files to point to a 404
    before :each do
      @config_backup_files.each do |backup_file|
        file_url = @module.uri.merge(URI.escape(backup_file)).to_s

        stub_request(:get, file_url).
          to_return(:status => 404, :body => "")
      end
    end

    it "shoud return an empty array if no config backup is present" do
      @module.config_backup.should be_empty
    end

    it "should return an array with 1 backup file" do
      expected = []

      @config_backup_files.sample(1).each do |backup_file|
        file_url = @module.uri.merge(URI.escape(backup_file)).to_s
        expected << file_url

        stub_request(:get, file_url).
          to_return(:status => 200, :body => File.new(@fixtures_dir + '/wp-config.php'))
      end

      wp_config_backup = @module.config_backup
      wp_config_backup.should_not be_empty
      wp_config_backup.should === expected
    end

    # Is there a way to factorise that one with the previous test ?
    it "should return an array with 2 backup file" do
      expected = []

      @config_backup_files.sample(2).each do |backup_file|
        file_url = @module.uri.merge(URI.escape(backup_file)).to_s
        expected << file_url

        stub_request(:get, file_url).
          to_return(:status => 200, :body => File.new(@fixtures_dir + '/wp-config.php'))
      end

      wp_config_backup = @module.config_backup
      wp_config_backup.should_not be_empty
      wp_config_backup.sort.should === expected.sort
    end
  end

end
