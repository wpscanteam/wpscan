# frozen_string_literal: true

describe OptParseValidator::OptDirectoryPath do
  subject(:opt)  { described_class.new(['-d', '--dir DIR'], attrs) }
  let(:attrs)    { {} }
  let(:dir_path) { OPV_FIXTURES.join('advanced_help').to_s }

  its(:attrs) { should eq directory: true }

  describe '#validate' do
    context 'when it is a directory' do
      it 'returns the path' do
        expect(opt.validate(dir_path)).to eql Pathname.new(dir_path)
      end
    end

    context 'when it\'s not ' do
      it 'raises an error' do
        expect { opt.validate('yolo.txt') }.to raise_error "The path 'yolo.txt' does not exist or is not a directory"
      end
    end

    context 'when the directory does not exist' do
      let(:dir_path) { OPV_FIXTURES.join('aaa') }

      it 'raises an error' do
        expect { opt.validate(dir_path) }.to raise_error "The path '#{dir_path}' does not exist or is not a directory"
      end
    end

    context 'when :create' do
      let(:attrs) { { create: true } }
      let(:dir_path) { OPV_FIXTURES.join('dir_path').to_s }

      it 'creates it' do
        expect(opt.validate(dir_path)).to eql Pathname.new(dir_path)
        expect(Dir.exist?(dir_path)).to eql true

        FileUtils.remove_dir(dir_path)
      end
    end
  end
end
