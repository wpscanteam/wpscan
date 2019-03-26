# frozen_string_literal: true

describe WPScan::Finders::ConfigBackups::KnownFilenames do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://ex.lo/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('config_backups') }
  let(:opts)       { { list: WPScan::DB_DIR.join('config_backups.txt').to_s } }

  describe '#aggressive' do
    before do
      expect(target).to receive(:sub_dir).at_least(1).and_return(false)
      expect(target).to receive(:head_or_get_params).and_return(method: :head)

      finder.potential_urls(opts).each_key do |url|
        stub_request(:head, url).to_return(status: 404)
      end
    end

    context 'when all files are 404s' do
      it 'returns an empty array' do
        expect(finder.aggressive(opts)).to eql []
      end
    end

    context 'when some files exist' do
      let(:found_files) { ['%23wp-config.php%23', 'wp-config.bak'] }
      let(:config_backup) { File.read(fixtures.join('wp-config.php')) }

      before do
        found_files.each do |file|
          stub_request(:head, "#{url}#{file}").to_return(status: 200)
          stub_request(:get, "#{url}#{file}").to_return(status: 200, body: config_backup)
        end

        expect(target).to receive(:homepage_or_404?).twice.and_return(false)
      end

      it 'returns the expected Array<ConfigBackup>' do
        expected = []

        found_files.each do |file|
          url = "#{target.url}#{file}"

          expected << WPScan::Model::ConfigBackup.new(
            url,
            confidence: 100,
            found_by: described_class::DIRECT_ACCESS
          )
        end

        expect(finder.aggressive(opts)).to eql expected
      end
    end
  end
end
