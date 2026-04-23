# frozen_string_literal: true

describe OptParseValidator::ConfigFilesLoaderMerger::ConfigFile::JSON do
  subject(:file) { described_class.new(fixtures.join(fixture)) }
  let(:fixtures) { OPV_FIXTURES.join('config_files_loader_merger') }

  describe '#parse' do
    # Handled in options_files_spec.rb#parse
  end
end
