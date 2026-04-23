# frozen_string_literal: true

describe OptParseValidator::OptHeaders do
  subject(:opt) { described_class.new(['--headers H'], attrs) }
  let(:attrs)   { {} }

  describe '#append_help_messages' do
    its(:help_messages) do
      should eql [
        "Separator to use between the headers: '; '",
        "Examples: 'X-Forwarded-For: 127.0.0.1', 'X-Forwarded-For: 127.0.0.1; Another: aaa'"
      ]
    end
  end

  describe '#validates' do
    context 'when malformed' do
      it 'raises an error' do
        ['Test', 'Test aa;', 'V: aa; Test'].each do |value|
          expect { opt.validate(value) }.to raise_error(OptParseValidator::Error)
        end
      end
    end

    context 'when valid' do
      context 'when basic headers' do
        it 'returns the expected hash' do
          expect(opt.validate('Test: aa')).to eql('Test' => 'aa')
          expect(opt.validate('Test: aa;')).to eql('Test' => 'aa')
          expect(opt.validate('T: aa; V: bb')).to eql('T' => 'aa', 'V' => 'bb')
          expect(opt.validate('T: aa; V:;')).to eql('T' => 'aa', 'V' => '')
        end
      end

      context 'when header content contains a : or ;' do
        it 'returns the expected hash' do
          expect(opt.validate('Referer: http://test.com')).to eql('Referer' => 'http://test.com')
          expect(opt.validate('Accept-Language: en-GB,en;q=0.5')).to eql('Accept-Language' => 'en-GB,en;q=0.5')
          expect(opt.validate('A-L: en-GB;q=0.5; R: http://t.com')).to eql('A-L' => 'en-GB;q=0.5', 'R' => 'http://t.com')
        end
      end
    end
  end
end
