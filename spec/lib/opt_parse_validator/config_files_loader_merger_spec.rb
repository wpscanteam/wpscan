# frozen_string_literal: true

describe OptParseValidator::ConfigFilesLoaderMerger do
  subject(:files)     { described_class.new }
  let(:fixtures)      { OPV_FIXTURES.join('config_files_loader_merger') }
  let(:default_file)  { fixtures.join('default.json') }
  let(:override_file) { fixtures.join('override.yml') }

  describe '#supported_extensions' do
    its(:supported_extensions) { %w[json yml] }
  end

  describe '#result_key' do
    its(:result_key) { should be_nil }
  end

  describe '#<<' do
    context 'when the file does not exist' do
      it 'returns self' do
        expect(files << 'not-there.json').to eql files
      end
    end

    context 'when the format is not supported' do
      it 'raises an error' do
        expect { files << fixtures.join('unsupported.ext') }
          .to raise_error(
            OptParseValidator::Error,
            "The option file's extension 'ext' is not supported"
          )
      end
    end

    context 'when the format is supported' do
      it 'adds the file' do
        files << default_file << override_file

        expect(files).to eq [
          OptParseValidator::ConfigFilesLoaderMerger::ConfigFile::JSON.new(default_file),
          OptParseValidator::ConfigFilesLoaderMerger::ConfigFile::YML.new(override_file)
        ]
      end
    end
  end

  describe '#parse' do
    before { files << default_file << override_file }

    let(:expected_hash) do
      {
        verbose: true, override_me: 'Yeaa',
        deep_merge: { p1: 'v2', p2: 'v3' }
      }
    end

    its(:parse) { should eql(expected_hash) }

    context 'when YAML class contains a regexp' do
      before { files << fixtures.join('regexp_class.yml') }

      its(:parse) { should include(pattern: /some (regexp)/i) }
    end

    context 'when result_key set' do
      before { files.result_key = 'cli_options' }

      context 'when result_key not in the results' do
        its(:parse) { should eql({}) }
      end

      context 'when result_key in the results' do
        before { files << fixtures.join('result_key.yml') }

        its(:parse) { should eql(verbose: false, hello: 'something') }
      end
    end
  end
end
