# frozen_string_literal: true

describe WPScan::DB::Updater do
  subject(:updater)    { described_class.new(repo_directory) }
  let(:repo_directory) { Pathname.new(Dir.mktmpdir) }
  let(:cli_args)       { '--url http://ex.lo/' }

  # Save/restore the enterprise token ENV var so it can't leak in or out of these examples
  around do |example|
    original = ENV.fetch('WPSCAN_ENTERPRISE_DB_TOKEN', nil)

    ENV.delete('WPSCAN_ENTERPRISE_DB_TOKEN')
    example.run
  ensure
    original ? ENV['WPSCAN_ENTERPRISE_DB_TOKEN'] = original : ENV.delete('WPSCAN_ENTERPRISE_DB_TOKEN')
  end

  before { WPScan::ParsedCli.options = rspec_parsed_options(cli_args) }

  after { FileUtils.remove_entry(repo_directory) if File.directory?(repo_directory) }

  describe '#enterprise_db_token' do
    context 'when neither the CLI option nor the ENV var is set' do
      its(:enterprise_db_token) { should be nil }
    end

    context 'when set via the CLI option' do
      let(:cli_args) { "#{super()} --enterprise-db-token cli-token" }

      its(:enterprise_db_token) { should eql 'cli-token' }
    end

    context 'when set via the ENV var' do
      before { ENV['WPSCAN_ENTERPRISE_DB_TOKEN'] = 'env-token' }

      its(:enterprise_db_token) { should eql 'env-token' }
    end

    context 'when set via both the CLI option and the ENV var' do
      let(:cli_args) { "#{super()} --enterprise-db-token cli-token" }

      before { ENV['WPSCAN_ENTERPRISE_DB_TOKEN'] = 'env-token' }

      it 'gives precedence to the CLI option' do
        expect(updater.enterprise_db_token).to eql 'cli-token'
      end
    end
  end

  describe '#files' do
    context 'when no enterprise token is set' do
      it 'returns the standard FILES only' do
        expect(updater.files).to eq described_class::FILES
      end
    end

    context 'when an enterprise token is set' do
      let(:cli_args) { "#{super()} --enterprise-db-token ent-token" }

      it 'appends the enterprise dumps to the standard FILES' do
        expect(updater.files).to eq(described_class::FILES + described_class::ENTERPRISE_FILES)
      end
    end
  end

  describe '#enterprise_file?' do
    context 'when no enterprise token is set' do
      it 'is false even for an enterprise dump filename' do
        expect(updater.enterprise_file?('plugins.json.gz')).to be false
      end
    end

    context 'when an enterprise token is set' do
      let(:cli_args) { "#{super()} --enterprise-db-token ent-token" }

      it 'is true for an enterprise dump filename' do
        expect(updater.enterprise_file?('plugins.json.gz')).to be true
      end

      it 'is false for a standard DB file' do
        expect(updater.enterprise_file?('metadata.json')).to be false
      end

      it 'is false for a nil filename' do
        expect(updater.enterprise_file?(nil)).to be false
      end
    end
  end

  describe '#remote_file_url' do
    context 'when no enterprise token is set' do
      it 'uses the default host for a standard DB file' do
        expect(updater.remote_file_url('metadata.json')).to eql 'https://data.wpscan.org/metadata.json'
      end

      it 'uses the default host even for an enterprise dump filename' do
        expect(updater.remote_file_url('plugins.json.gz')).to eql 'https://data.wpscan.org/plugins.json.gz'
      end
    end

    context 'when an enterprise token is set' do
      let(:cli_args) { "#{super()} --enterprise-db-token ent-token" }

      it 'uses the enterprise host for an enterprise dump' do
        expect(updater.remote_file_url('plugins.json.gz'))
          .to eql 'https://enterprise-data.wpscan.org/plugins.json.gz'
      end

      it 'still uses the default host for a standard DB file' do
        expect(updater.remote_file_url('metadata.json')).to eql 'https://data.wpscan.org/metadata.json'
      end
    end
  end

  describe '#request_params' do
    before { WPScan::Browser.instance.load_options(WPScan::ParsedCli.options.dup) }

    # Reset the singleton Browser state so proxy flags set here don't leak into other specs
    after do
      WPScan::Browser.instance.proxy = nil
      WPScan::Browser.instance.proxy_auth = nil
    end

    context 'when no enterprise token is set' do
      it 'does not set the enterprise auth header and keeps accept_encoding' do
        params = updater.request_params('metadata.json')

        expect(params[:headers]).to_not have_key('X-DB-JSON-AUTH')
        expect(params[:accept_encoding]).to eql 'gzip, deflate'
      end

      it 'behaves the same when called without a filename' do
        params = updater.request_params

        expect(params[:headers]).to_not have_key('X-DB-JSON-AUTH')
        expect(params[:accept_encoding]).to eql 'gzip, deflate'
      end
    end

    context 'when an enterprise token is set' do
      let(:cli_args) { "#{super()} --enterprise-db-token ent-token" }

      it 'sets the auth header and removes accept_encoding for an enterprise dump' do
        params = updater.request_params('plugins.json.gz')

        expect(params[:headers]['X-DB-JSON-AUTH']).to eql 'ent-token'
        expect(params).to_not have_key(:accept_encoding)
      end

      it 'does not set the auth header (and keeps accept_encoding) for a standard DB file' do
        params = updater.request_params('metadata.json')

        expect(params[:headers]).to_not have_key('X-DB-JSON-AUTH')
        expect(params[:accept_encoding]).to eql 'gzip, deflate'
      end
    end

    context 'when --proxy is set with --proxy-target-only' do
      let(:cli_args) { "#{super()} --proxy http://127.0.0.1:8080 --proxy-target-only" }

      it 'strips the proxy from the params' do
        expect(updater.request_params('metadata.json')).to_not have_key(:proxy)
      end
    end
  end

  describe '#missing_files?' do
    context 'when an enterprise token is set' do
      let(:cli_args) { "#{super()} --enterprise-db-token ent-token" }

      # Create every standard DB file so that only the enterprise dumps can be considered missing
      before { described_class::FILES.each { |file| FileUtils.touch(repo_directory.join(file)) } }

      it 'is true while the enterprise dumps are absent' do
        expect(updater.missing_files?).to be true
      end

      it 'is false once the enterprise dumps are present too' do
        described_class::ENTERPRISE_FILES.each { |file| FileUtils.touch(repo_directory.join(file)) }

        expect(updater.missing_files?).to be false
      end
    end
  end
end
