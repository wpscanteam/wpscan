# frozen_string_literal: true

describe WPScan::Finders::BackupFolders::KnownLocations do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://ex.lo/' }

  describe '#aggressive' do
    context 'when backup folders exist with directory listing' do
      it 'returns backup folders with high severity' do
        # Mock the target methods to avoid making real requests
        allow(target).to receive(:head_and_get).and_return(
          double('Response', code: 200)
        )
        allow(target).to receive(:homepage_or_404?).and_return(false)
        allow(target).to receive(:directory_listing_entries).and_return(['backup.zip'])
        allow(target).to receive(:url) do |path|
          "#{url}#{path}"
        end

        findings = finder.aggressive

        expect(findings.compact).not_to be_empty

        # Check for specific backup folders
        dup_pro = findings.find { |f| f&.url == "#{url}wp-content/backups-dup-pro/" }
        expect(dup_pro).not_to be_nil
        expect(dup_pro.confidence).to eq 100
        expect(dup_pro.response_code).to eq 200
        expect(dup_pro.plugin_name).to eq 'Duplicator Pro'
      end
    end

    context 'when backup folders exist but are forbidden' do
      it 'returns backup folders with medium severity' do
        allow(target).to receive(:head_and_get).and_return(
          double('Response', code: 403)
        )
        allow(target).to receive(:homepage_or_404?).and_return(false)
        allow(target).to receive(:directory_listing_entries).and_return([])
        allow(target).to receive(:url) do |path|
          "#{url}#{path}"
        end

        findings = finder.aggressive

        backup_db = findings.find { |f| f&.url == "#{url}wp-content/backup-db/" }
        expect(backup_db).not_to be_nil
        expect(backup_db.confidence).to eq 70
        expect(backup_db.response_code).to eq 403
        expect(backup_db.plugin_name).to eq 'WP-DB-Backup'
      end
    end

    context 'when no backup folders exist' do
      it 'returns an empty array' do
        allow(target).to receive(:head_and_get).and_return(
          double('Response', code: 404)
        )
        allow(target).to receive(:homepage_or_404?).and_return(true)
        allow(target).to receive(:url) do |path|
          "#{url}#{path}"
        end

        expect(finder.aggressive.compact).to be_empty
      end
    end

    context 'when checking BackWPup parent folder' do
      it 'detects BackWPup parent folder' do
        # Allow default behavior for most folders
        allow(target).to receive(:head_and_get).and_return(
          double('Response', code: 404)
        )

        # Specific response for backwpup parent folder
        allow(target).to receive(:head_and_get)
          .with('wp-content/uploads/backwpup/', anything)
          .and_return(double('Response', code: 200))

        allow(target).to receive(:homepage_or_404?).and_return(false)
        allow(target).to receive(:directory_listing_entries).and_return(['e0ed9f/', 'logs/'])
        allow(target).to receive(:url) do |path|
          "#{url}#{path}"
        end

        findings = finder.aggressive
        backwpup = findings.find { |f| f&.url == "#{url}wp-content/uploads/backwpup/" }

        expect(backwpup).not_to be_nil
        expect(backwpup.confidence).to eq 100  # 200 response = 100 confidence
        expect(backwpup.plugin_name).to eq 'BackWPup'
        expect(backwpup.found_by).to eq 'Direct Access (Aggressive Detection)'
      end
    end
  end
end
