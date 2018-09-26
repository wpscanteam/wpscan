require 'spec_helper'

describe WPScan::Finders::DbExports::KnownLocations do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://ex.lo/aa/' }
  let(:fixtures)   { File.join(FINDERS_FIXTURES, 'db_exports') }
  let(:opts)       { { list: File.join(WPScan::DB_DIR, 'db_exports.txt') } }

  describe '#potential_urls' do
    before do
      expect(target).to receive(:sub_dir).at_least(1).and_return(false)
    end

    it 'replace {domain_name} by its value' do
      expect(finder.potential_urls(opts).keys).to eql %w[
        http://ex.lo/aa/ex.sql
        http://ex.lo/aa/wordpress.sql
        http://ex.lo/aa/backup/ex.zip
        http://ex.lo/aa/backup/mysql.sql
        http://ex.lo/aa/backups/ex.sql.gz
        http://ex.lo/aa/backups/db_backup.sql
      ]
    end
  end

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
      let(:files) { %w[ex.sql backups/db_backup.sql] }
      let(:db_export) { File.read(File.join(fixtures, 'dump.sql')) }

      before do
        files.each do |file|
          stub_request(:get, "#{url}#{file}").to_return(body: db_export)
        end
      end

      it 'returns the expected Array<DbExport>' do
        expected = []

        files.each do |file|
          url = "#{target.url}#{file}"
          expected << WPScan::DbExport.new(
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
