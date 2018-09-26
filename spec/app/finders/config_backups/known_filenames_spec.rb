require 'spec_helper'

describe WPScan::Finders::ConfigBackups::KnownFilenames do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://ex.lo/' }
  let(:fixtures)   { File.join(FINDERS_FIXTURES, 'config_backups') }
  let(:opts)       { { list: File.join(WPScan::DB_DIR, 'config_backups.txt') } }

  describe '#aggressive' do
    before do
      expect(target).to receive(:sub_dir).at_least(1).and_return(false)
      expect(target).to receive(:homepage_or_404?).at_least(1).and_return(false)

      finder.potential_urls(opts).each_key do |url|
        stub_request(:get, url).to_return(status: 404)
      end
    end

    context 'when all files are 404s' do
      it 'returns an empty array' do
        expect(finder.aggressive(opts)).to eql []
      end
    end

    context 'when some files exist' do
      let(:files) { ['%23wp-config.php%23', 'wp-config.bak'] }
      let(:config_backup) { File.read(File.join(fixtures, 'wp-config.php')) }

      before do
        files.each do |file|
          stub_request(:get, "#{url}#{file}").to_return(body: config_backup)
        end
      end

      it 'returns the expected Array<ConfigBackup>' do
        expected = []

        files.each do |file|
          url = "#{target.url}#{file}"
          expected << WPScan::ConfigBackup.new(
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
