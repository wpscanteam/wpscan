# frozen_string_literal: true

describe WPScan::Finders::ConfigBackups::Base do
  subject(:config_backups) { described_class.new(target) }
  let(:target)             { WPScan::Target.new(url) }
  let(:url)                { 'http://ex.lo/' }

  describe '#finders' do
    it 'contains the expected finders' do
      expect(config_backups.finders.map { |f| f.class.to_s.demodulize }).to eq %w[KnownFilenames]
    end
  end
end
