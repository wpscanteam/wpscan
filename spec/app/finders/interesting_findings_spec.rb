# frozen_string_literal: true

describe WPScan::Finders::InterestingFindings::Base do
  subject(:files) { described_class.new(target) }
  let(:target)    { WPScan::Target.new(url) }
  let(:url)       { 'http://ex.lo/' }

  describe '#finders' do
    let(:expected) do
      %w[
        Readme DebugLog FullPathDisclosure
        Multisite MuPlugins Registration UploadDirectoryListing TmmDbMigrate
        UploadSQLDump
      ]
    end

    it 'contains the expected finders' do
      expect(files.finders.map { |f| f.class.to_s.demodulize }).to include(*expected)
    end
  end
end
