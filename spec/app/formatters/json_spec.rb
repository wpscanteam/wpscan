# frozen_string_literal: true

describe WPScan::Formatter::Json do
  it_behaves_like WPScan::Formatter::Buffer

  subject(:formatter) { described_class.new }
  let(:output_file)   { FIXTURES.join('output.txt') }

  before { formatter.views_directories << FIXTURES_VIEWS }

  its(:format)            { should eq 'json' }
  its(:user_interaction?) { should be false }

  describe '#output' do
    it 'puts the rendered text in the buffer' do
      2.times { formatter.output('@render_me', test: 'Working') }

      expect(formatter.buffer).to eq "\"test\": \"Working\",\n" * 2
    end
  end

  describe '#beautify' do
    it 'writes the buffer in the $stdout' do
      2.times { formatter.output('@render_me', test: 'yolo') }

      expect($stdout).to receive(:puts).with(JSON.pretty_generate(JSON.parse('{"test": "yolo"}')))
      formatter.beautify
    end

    context 'when invalid UTF-8 chars' do
      it 'tries to convert/replace them' do
        formatter.output('@render_me', test: "\x93it\x92s".dup.force_encoding('CP1252'))

        replacement = "\uFFFD"
        expected_json = "{\"test\": \"#{replacement}it#{replacement}s\"}"
        expect($stdout).to receive(:puts).with(JSON.pretty_generate(JSON.parse(expected_json)))
        formatter.beautify
      end
    end
  end
end
