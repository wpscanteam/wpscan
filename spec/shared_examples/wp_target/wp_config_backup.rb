# encoding: UTF-8

shared_examples 'WpTarget::WpConfigBackup' do

  let(:fixtures_dir) { SPEC_FIXTURES_WPSCAN_WP_TARGET_DIR + '/wp_config_backup' }
  let(:config_backup_files) { WpTarget::WpConfigBackup.config_backup_files }

  describe '#config_backup' do

    # set all @config_backup_files to point to a 404
    before :each do
      config_backup_files.each do |backup_file|
        file_url = wp_target.uri.merge(URI.escape(backup_file)).to_s

        stub_request(:get, file_url).to_return(status: 404)
      end
    end

    it 'shoud return an empty array if no config backup is present' do
      wp_target.config_backup.should be_empty
    end

    it 'returns an array with 1 backup file' do
      expected = []

      config_backup_files.sample(1).each do |backup_file|
        file_url = wp_target.uri.merge(URI.escape(backup_file)).to_s
        expected << file_url

        stub_request_to_fixture(url: file_url, fixture: fixtures_dir + '/wp-config.php')
      end

      wp_config_backup = wp_target.config_backup
      wp_config_backup.should_not be_empty
      wp_config_backup.should === expected
    end

    # Is there a way to factorise that one with the previous test ?
    it 'returns an array with 2 backup file' do
      expected = []

      config_backup_files.sample(2).each do |backup_file|
        file_url = wp_target.uri.merge(URI.escape(backup_file)).to_s
        expected << file_url

        stub_request_to_fixture(url: file_url, fixture: fixtures_dir + '/wp-config.php')
      end

      wp_config_backup = wp_target.config_backup
      wp_config_backup.should_not be_empty
      wp_config_backup.sort.should === expected.sort
    end
  end

  describe '#config_backup_files' do
    it 'does not contain duplicates' do
      config_backup_files.flatten.uniq.length.should == config_backup_files.length
    end
  end

end
