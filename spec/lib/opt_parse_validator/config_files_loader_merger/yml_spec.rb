# frozen_string_literal: true

describe OptParseValidator::ConfigFilesLoaderMerger::ConfigFile::YML do
  subject(:file) { described_class.new(fixtures.join(fixture)) }
  let(:fixtures) { OPV_FIXTURES.join('config_files_loader_merger') }

  describe '#parse' do
    # Handled in options_files_spec.rb#parse

    context 'when the file is empty' do
      let(:fixture) { 'empty_file' }

      its(:parse) { should eql({}) }
    end

    context 'when file contains a non whitelisted class' do
      let(:fixture) { 'date_class.yml' }

      it 'raises an error' do
        expect { file.parse }.to raise_error(Psych::DisallowedClass)
      end
    end

    context 'when file contains a whitelisted class (regexp)' do
      let(:fixture) { 'regexp_class.yml' }

      its(:parse) { should eql('pattern' => /some (regexp)/i) }
    end
  end
end
