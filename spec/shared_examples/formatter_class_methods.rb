# frozen_string_literal: true

shared_examples WPScan::Formatter::ClassMethods do
  describe '#load' do
    context 'w/o parameter' do
      it 'loads the default formatter' do
        expect(subject.load).to be_a subject::Cli
      end
    end

    it 'loads the correct formatter' do
      expect(subject.load('cli_no_colour')).to be_a subject::CliNoColour
    end

    it 'adds the custom_views' do
      formatter = subject.load(nil, %w[/path/views1 /path2/views])

      expect(formatter.views_directories).to include('/path/views1', '/path2/views')
    end
  end

  describe '#availables' do
    it 'returns the right list' do
      expect(subject.availables).to match_array(%w[json sarif cli-no-colour cli-no-color cli])
    end
  end
end
