# frozen_string_literal: true

describe WPScan::Model::BackupFolder do
  subject(:backup_folder) { described_class.new(url, opts) }
  let(:url)               { 'http://ex.lo/wp-content/backups-dup-pro/' }
  let(:opts)              { {} }

  describe '#to_s' do
    context 'when directory listing has entries' do
      let(:opts) { { interesting_entries: ['backup.zip', 'backup2.zip'] } }

      it 'includes entry count' do
        expected = 'Backup folder found: http://ex.lo/wp-content/backups-dup-pro/ (2 entries)'
        expect(backup_folder.to_s).to eq expected
      end
    end

    context 'when directory listing is empty' do
      let(:opts) { { interesting_entries: [] } }

      it 'shows basic message' do
        expect(backup_folder.to_s).to eq 'Backup folder found: http://ex.lo/wp-content/backups-dup-pro/'
      end
    end

    context 'when no interesting_entries provided' do
      it 'shows basic message' do
        expect(backup_folder.to_s).to eq 'Backup folder found: http://ex.lo/wp-content/backups-dup-pro/'
      end
    end
  end

  describe '#severity' do
    context 'when directory listing has files' do
      let(:opts) { { interesting_entries: ['backup.zip'] } }

      it 'returns high severity' do
        expect(backup_folder.severity).to eq :high
      end
    end

    context 'when directory listing is empty' do
      let(:opts) { { interesting_entries: [] } }

      it 'returns medium severity' do
        expect(backup_folder.severity).to eq :medium
      end
    end

    context 'when no interesting_entries provided' do
      it 'returns medium severity' do
        expect(backup_folder.severity).to eq :medium
      end
    end
  end

  describe '#interesting_entries' do
    context 'when there are many entries' do
      let(:entries) { (1..15).map { |i| "file#{i}.zip" } }
      let(:opts) { { interesting_entries: entries } }

      it 'limits to MAX_ENTRIES_DISPLAY and adds summary' do
        result = backup_folder.interesting_entries
        expect(result.size).to eq 11 # 10 entries + 1 summary line
        expect(result.first).to eq 'file1.zip'
        expect(result[9]).to eq 'file10.zip'
        expect(result.last).to eq '... and 5 more'
      end
    end

    context 'when entries are within limit' do
      let(:opts) { { interesting_entries: ['file1.zip', 'file2.zip'] } }

      it 'returns all entries without summary' do
        result = backup_folder.interesting_entries
        expect(result).to eq ['file1.zip', 'file2.zip']
      end
    end
  end
end
