# frozen_string_literal: true

describe WPScan::Finders::BackupFolders::KnownLocations do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://ex.lo/' }
  let(:opts)       { { list: WPScan::DB_DIR.join('backup_folders.txt').to_s } }

  describe '#aggressive' do
    before do
      allow(target).to receive(:content_dir).and_return('wp-content')
      allow(target).to receive(:sub_dir).and_return(false)
      allow(target).to receive(:head_or_get_params).and_return(method: :head)

      # Stub homepage for homepage_or_404? check
      stub_request(:get, url).to_return(status: 200, body: 'homepage')

      # Stub all potential URLs with 404 by default
      finder.potential_urls(opts).each_key do |url|
        stub_request(:head, url).to_return(status: 404)
      end
    end

    context 'when all folders are 404s' do
      it 'returns an empty array' do
        expect(finder.aggressive(opts)).to eql []
      end
    end

    context 'when backup folders exist with directory listing' do
      before do
        # Stub specific folders to return 200
        stub_request(:head, "#{url}wp-content/backups-dup-pro/").to_return(status: 200)
        stub_request(:get, "#{url}wp-content/backups-dup-pro/").to_return(
          status: 200,
          body: '<html><body><a href="backup.zip">backup.zip</a></body></html>'
        )

        allow(target).to receive(:homepage_or_404?).and_return(false)
        allow(target).to receive(:directory_listing_entries)
          .with("#{url}wp-content/backups-dup-pro/")
          .and_return(['backup.zip'])
      end

      it 'returns backup folders with high confidence' do
        findings = finder.aggressive(opts)

        expect(findings).not_to be_empty

        dup_pro = findings.first
        expect(dup_pro.url).to eq "#{url}wp-content/backups-dup-pro/"
        expect(dup_pro.confidence).to eq 100
        expect(dup_pro.response_code).to eq 200
        expect(dup_pro.plugin_name).to eq 'Duplicator Pro'
        expect(dup_pro.interesting_entries).to eq ['backup.zip']
      end
    end

    context 'when backup folders exist but are forbidden' do
      before do
        # Stub specific folders to return 403
        stub_request(:head, "#{url}wp-content/backup-db/").to_return(status: 403)
        stub_request(:get, "#{url}wp-content/backup-db/").to_return(status: 403)

        allow(target).to receive(:homepage_or_404?).and_return(false)
      end

      it 'returns backup folders with medium confidence' do
        findings = finder.aggressive(opts)

        expect(findings).not_to be_empty

        backup_db = findings.find { |f| f.url == "#{url}wp-content/backup-db/" }
        expect(backup_db).not_to be_nil
        expect(backup_db.confidence).to eq 70
        expect(backup_db.response_code).to eq 403
        expect(backup_db.plugin_name).to eq 'WP-DB-Backup'
        expect(backup_db.interesting_entries).to eq []
      end
    end

    context 'when multiple backup folders exist' do
      before do
        # Stub two folders - one 200, one 403
        stub_request(:head, "#{url}wp-content/updraft/").to_return(status: 200)
        stub_request(:get, "#{url}wp-content/updraft/").to_return(
          status: 200,
          body: '<html><body>Directory listing</body></html>'
        )

        stub_request(:head, "#{url}wp-content/uploads/backwpup/").to_return(status: 403)
        stub_request(:get, "#{url}wp-content/uploads/backwpup/").to_return(status: 403)

        allow(target).to receive(:homepage_or_404?).and_return(false)
        allow(target).to receive(:directory_listing_entries)
          .with("#{url}wp-content/updraft/")
          .and_return([])
      end

      it 'returns all detected backup folders' do
        findings = finder.aggressive(opts)

        expect(findings.size).to eq 2

        updraft = findings.find { |f| f.url == "#{url}wp-content/updraft/" }
        expect(updraft).not_to be_nil
        expect(updraft.confidence).to eq 100
        expect(updraft.plugin_name).to eq 'UpdraftPlus'

        backwpup = findings.find { |f| f.url == "#{url}wp-content/uploads/backwpup/" }
        expect(backwpup).not_to be_nil
        expect(backwpup.confidence).to eq 70
        expect(backwpup.plugin_name).to eq 'BackWPup'
      end
    end

    context 'when using custom content directory' do
      before do
        allow(target).to receive(:content_dir).and_return('custom-content')

        # Re-stub URLs with custom content directory
        finder.potential_urls(opts).each_key do |url|
          stub_request(:head, url).to_return(status: 404)
        end

        # Stub specific folder in custom content directory
        stub_request(:head, "#{url}custom-content/updraft/").to_return(status: 200)
        stub_request(:get, "#{url}custom-content/updraft/").to_return(
          status: 200,
          body: '<html><body><a href="backup.zip">backup.zip</a></body></html>'
        )

        allow(target).to receive(:homepage_or_404?).and_return(false)
        allow(target).to receive(:directory_listing_entries)
          .with("#{url}custom-content/updraft/")
          .and_return(['backup.zip'])
      end

      it 'detects backup folders in custom content directory' do
        findings = finder.aggressive(opts)

        expect(findings).not_to be_empty

        updraft = findings.first
        expect(updraft.url).to eq "#{url}custom-content/updraft/"
        expect(updraft.confidence).to eq 100
        expect(updraft.plugin_name).to eq 'UpdraftPlus'
      end
    end
  end
end
