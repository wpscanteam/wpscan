# frozen_string_literal: true

describe OptParseValidator::ConfigFilesLoaderMerger::ConfigFile::Base do
  subject(:file) { described_class.new('test') }

  describe '#parse' do
    it 'raises an error' do
      expect { file.parse }.to raise_error NotImplementedError
    end
  end

  describe '#==' do
    # Handled in options_files_spec.rb#<<
  end
end
