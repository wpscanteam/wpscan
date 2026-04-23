# frozen_string_literal: true

describe WPScan::Formatter::Cli do
  subject(:formatter) { described_class.new }

  its(:format)            { should eq 'cli' }
  its(:user_interaction?) { should be true }

  describe '#bold, #red, #green, #amber, #blue, #colorize' do
    it 'returns the correct bold string' do
      expect(formatter.bold('Text')).to eq "\e[1mText\e[0m"
    end

    it 'returns the correct red string' do
      expect(formatter.red('Text')).to eq "\e[31mText\e[0m"
    end

    it 'returns the correct green string' do
      expect(formatter.green('Another Text')).to eq "\e[32mAnother Text\e[0m"
    end

    it 'returns the correct amber string' do
      expect(formatter.amber('Text')).to eq "\e[33mText\e[0m"
    end

    it 'returns the correct blue string' do
      expect(formatter.blue('Text')).to eq "\e[34mText\e[0m"
    end
  end

  describe '#*_icon' do
    {
      info: "\e[32m[+]\e[0m",
      notice: "\e[34m[i]\e[0m",
      warning: "\e[33m[!]\e[0m",
      critical: "\e[31m[!]\e[0m"
    }.each do |icon_type, expected|
      it "returns the correct #{icon_type} icon" do
        expect(formatter.send("#{icon_type}_icon")).to eql expected
      end
    end
  end
end
