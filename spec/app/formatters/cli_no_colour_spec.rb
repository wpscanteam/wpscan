# frozen_string_literal: true

describe WPScan::Formatter::CliNoColour do
  subject(:formatter) { described_class.new }

  its(:format)            { should eq 'cli' }
  its(:user_interaction?) { should be true }

  describe '#colorize' do
    it 'returns the text w/o any colour' do
      expect(formatter.red('Text')).to eq 'Text'
    end
  end
end
