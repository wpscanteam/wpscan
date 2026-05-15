# frozen_string_literal: true

describe WPScan::Finders::BackupFolders::KnownLocations do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://ex.lo/' }
  let(:opts)       { { list: WPScan::DB_DIR.join('backup_folders.txt') } }

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
          body: '<html><body><h1>Index of /wp-content/backups-dup-pro/</h1>' \
                '<a href="backup.zip">backup.zip</a></body></html>'
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
        expect(dup_pro.interesting_entries).to eq ['backup.zip']
      end
    end

    context 'when backup folders exist but directory listing is disabled' do
      before do
        # Stub folder to return 200 but without directory listing
        stub_request(:head, "#{url}wp-content/backup-db/").to_return(status: 200)
        stub_request(:get, "#{url}wp-content/backup-db/").to_return(
          status: 200,
          body: '<html><body>Access forbidden</body></html>'
        )

        allow(target).to receive(:homepage_or_404?).and_return(false)
      end

      it 'does not report the folder' do
        findings = finder.aggressive(opts)

        expect(findings).to be_empty
      end
    end

    context 'when multiple backup folders exist with directory listing' do
      before do
        # Stub two folders with directory listing enabled
        stub_request(:head, "#{url}wp-content/updraft/").to_return(status: 200)
        stub_request(:get, "#{url}wp-content/updraft/").to_return(
          status: 200,
          body: '<html><body><h1>Index of /wp-content/updraft/</h1></body></html>'
        )

        stub_request(:head, "#{url}wp-content/uploads/backwpup/").to_return(status: 200)
        stub_request(:get, "#{url}wp-content/uploads/backwpup/").to_return(
          status: 200,
          body: '<html><body><h1>Index of /wp-content/uploads/backwpup/</h1>' \
                '<a href="backup.zip">backup.zip</a></body></html>'
        )

        allow(target).to receive(:homepage_or_404?).and_return(false)
        allow(target).to receive(:directory_listing_entries)
          .with("#{url}wp-content/updraft/")
          .and_return([])
        allow(target).to receive(:directory_listing_entries)
          .with("#{url}wp-content/uploads/backwpup/")
          .and_return(['backup.zip'])
      end

      it 'returns all detected backup folders' do
        findings = finder.aggressive(opts)

        expect(findings.size).to eq 2

        updraft = findings.find { |f| f.url == "#{url}wp-content/updraft/" }
        expect(updraft).not_to be_nil
        expect(updraft.confidence).to eq 100

        backwpup = findings.find { |f| f.url == "#{url}wp-content/uploads/backwpup/" }
        expect(backwpup).not_to be_nil
        expect(backwpup.confidence).to eq 100
      end
    end

    context 'when using custom content directory' do
      before do
        allow(target).to receive(:content_dir).and_return('custom-content')

        # Re-stub URLs with custom content directory
        finder.potential_urls(opts).each_key do |url|
          stub_request(:head, url).to_return(status: 404)
        end

        # Stub specific folder in custom content directory with directory listing
        stub_request(:head, "#{url}custom-content/updraft/").to_return(status: 200)
        stub_request(:get, "#{url}custom-content/updraft/").to_return(
          status: 200,
          body: '<html><body><h1>Index of /custom-content/updraft/</h1>' \
                '<a href="backup.zip">backup.zip</a></body></html>'
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
      end
    end
  end
end
