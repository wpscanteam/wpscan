# frozen_string_literal: true

describe WPScan::Model::InterestingFinding do
  it_behaves_like WPScan::Finders::Finding

  it_behaves_like WPScan::References do
    subject(:finding) { described_class.new('http://e.org/file.php', opts) }
    let(:opts)        { { references: references } }
    let(:references)  { {} }
  end

  subject(:finding) { described_class.new(url, opts) }
  let(:opts)        { {} }
  let(:url)         { 'http://example.com/' }
  let(:fixtures)    { FIXTURES_FINDERS.join('interesting_findings') }

  describe '#to_s' do
    context 'when no opts[:to_s]' do
      its(:to_s) { should eql url }

      context 'when setter used' do
        it 'returns the value from the setter' do
          finding.to_s = 'also works'

          expect(finding.to_s).to eql 'also works'
        end
      end
    end

    context 'when opts[:to_s]' do
      let(:opts) { super().merge(to_s: 'works') }

      its(:to_s) { should eql 'works' }

      context 'when setter used' do
        it 'returns the value from the setter' do
          finding.to_s = 'also works'

          expect(finding.to_s).to eql 'also works'
        end
      end
    end
  end

  describe '#type' do
    its(:type) { should eql 'interesting_finding' }
  end

  describe '#entries' do
    after do
      stub_request(:get, finding.url).to_return(headers: headers, body: @body)

      expect(finding.entries).to eq @expected
    end

    context 'when content-type matches text/plain' do
      let(:headers) { { 'Content-Type' => 'text/plain; charset=utf-8' } }

      it 'returns the finding content as an array w/o empty strings' do
        @body     = File.read(fixtures.join('file.txt'))
        @expected = ['This is', 'a test file', 'with some content']
      end
    end

    context 'when other content-type' do
      let(:headers) { { 'Content-Type' => 'text.html; charset=utf-8' } }

      it 'returns an empty array' do
        @expected = []
      end
    end
  end

  describe '#==' do
    context 'when same URL' do
      context 'when the same #to_s' do
        it 'returns true' do
          expect(finding == described_class.new(url)).to be true
        end
      end

      context 'when different #to_s' do
        it 'returns false' do
          expect(finding == described_class.new(url, to_s: 'another')).to be false
        end
      end
    end

    context 'when not the same URL' do
      it 'returns false' do
        expect(finding == described_class.new('http://e.org')).to be false
      end
    end
  end

  describe '#<=>' do
    context 'when same URL' do
      it 'returns 0' do
        expect(finding <=> described_class.new(url)).to eql 0
      end
    end

    context 'when the other URL <= current one' do
      it 'returns 1' do
        expect(finding <=> described_class.new('http://e.org')).to eql 1
      end
    end

    context 'when the other URL >= current one' do
      it 'returns -1' do
        expect(finding <=> described_class.new('http://exi.org/')).to eql(-1)
      end
    end

    context 'when using capitals' do
      it 'returns -1' do
        expect(finding <=> described_class.new('Sftp://a.org')).to eql(-1)
      end
    end
  end
end
