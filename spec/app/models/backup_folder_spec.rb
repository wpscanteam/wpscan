# frozen_string_literal: true

describe WPScan::Model::BackupFolder do
  subject(:backup_folder) { described_class.new(url, opts) }
  let(:url)               { 'http://ex.lo/wp-content/backups-dup-pro/' }
  let(:opts)              { {} }

  describe '#new' do
    context 'when response_code is provided' do
      let(:opts) { { response_code: 200 } }

      it 'sets the response_code attribute' do
        expect(backup_folder.response_code).to eq 200
      end
    end
  end

  describe '#to_s' do
    context 'when directory listing is enabled (200)' do
      let(:opts) { { response_code: 200, interesting_entries: ['backup.zip'] } }

      it 'includes directory listing message' do
        expected = 'Backup folder found: http://ex.lo/wp-content/backups-dup-pro/ (Directory listing enabled!)'
        expect(backup_folder.to_s).to eq expected
      end
    end

    context 'when access is forbidden (403)' do
      let(:opts) { { response_code: 403 } }

      it 'includes forbidden message' do
        expected = 'Backup folder found: http://ex.lo/wp-content/backups-dup-pro/ ' \
                   '(Access forbidden but folder exists)'
        expect(backup_folder.to_s).to eq expected
      end
    end

    context 'when no response code' do
      it 'shows basic message' do
        expect(backup_folder.to_s).to eq 'Backup folder found: http://ex.lo/wp-content/backups-dup-pro/'
      end
    end
  end

  describe '#severity' do
    context 'when directory listing is enabled with files' do
      let(:opts) { { response_code: 200, interesting_entries: ['backup.zip'] } }

      it 'returns high severity' do
        expect(backup_folder.severity).to eq :high
      end
    end

    context 'when directory listing is enabled but empty' do
      let(:opts) { { response_code: 200, interesting_entries: [] } }

      it 'returns medium severity' do
        expect(backup_folder.severity).to eq :medium
      end
    end

    context 'when folder exists but access is forbidden' do
      let(:opts) { { response_code: 403 } }

      it 'returns low severity' do
        expect(backup_folder.severity).to eq :low
      end
    end
  end

  describe '#plugin_name' do
    context 'when URL contains known plugin path' do
      [
        ['http://ex.lo/wp-content/backups-dup-pro/', 'Duplicator Pro'],
        ['http://ex.lo/wp-content/backups-dup-lite/', 'Duplicator'],
        ['http://ex.lo/wp-content/updraft/', 'UpdraftPlus'],
        ['http://ex.lo/wp-content/backup-db/', 'WP-DB-Backup'],
        ['http://ex.lo/wp-content/uploads/db-backup/', 'WP Database Backup'],
        ['http://ex.lo/wp-content/uploads/backwpup/', 'BackWPup']
      ].each do |test_url, expected_plugin|
        context "for #{test_url}" do
          let(:url) { test_url }

          it "returns '#{expected_plugin}'" do
            expect(backup_folder.plugin_name).to eq expected_plugin
          end
        end
      end
    end

    context 'when URL does not match any known plugin' do
      let(:url) { 'http://ex.lo/wp-content/unknown-backup/' }

      it 'returns Unknown Backup Plugin' do
        expect(backup_folder.plugin_name).to eq 'Unknown Backup Plugin'
      end
    end
  end

end
