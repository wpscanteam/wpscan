# frozen_string_literal: true

describe WPScan::Finders::DbExports::KnownLocations do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://ex.lo/aa/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('db_exports') }
  let(:opts)       { { list: WPScan::DB_DIR.join('db_exports.txt').to_s } }

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

    context 'when a zip returns a 200' do
      xit
    end

    context 'when some files exist' do
      let(:found_files) { %w[ex.sql backups/db_backup.sql] }
      let(:db_export) { File.read(fixtures.join('dump.sql')) }

      before do
        found_files.each do |file|
          stub_request(:head, "#{url}#{file}").to_return(status: 200)

          stub_request(:get, "#{url}#{file}")
            .with(headers: { 'Range' => 'bytes=0-3000' })
            .to_return(body: db_export)
        end

        expect(target).to receive(:homepage_or_404?).twice.and_return(false)
      end

      it 'returns the expected Array<DbExport>' do
        expected = []

        found_files.each do |file|
          url = "#{target.url}#{file}"
          expected << WPScan::Model::DbExport.new(
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
