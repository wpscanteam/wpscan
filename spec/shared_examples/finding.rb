# frozen_string_literal: true

shared_examples WPScan::Finders::Finding do
  it_behaves_like WPScan::References do
    let(:opts)       { { references: references } }
    let(:references) { {} }
  end

  %i[confirmed_by interesting_entries].each do |opt|
    describe "##{opt}" do
      its(opt) { should eq [] }

      context 'when supplied in the #new' do
        let(:opts) { { opt => 'test' } }

        its(opt) { should eq 'test' }
      end
    end
  end

  describe '#confidence, #confidence=' do
    its(:confidence) { should eql 0 }

    context 'when already set' do
      before { subject.confidence = 10 }

      its(:confidence) { should eql 10 }
    end

    context 'when another confidence added' do
      it 'adds it the the actual' do
        subject.confidence += 30
        expect(subject.confidence).to eql 30
      end

      it 'sets it to 100 if >= 100' do
        subject.confidence += 120
        expect(subject.confidence).to eql 100
      end
    end
  end

  describe '#parse_finding_options' do
    it 'sets the finding options from the provided hash' do
      opts = {
        confidence: 80,
        confirmed_by: ['Confirmed By Test'],
        found_by: 'Found By Test',
        interesting_entries: ['Entry 1', 'Entry 2'],
        references: { cve: ['2021-1234'], wpvulndb: ['9999'] }
      }

      subject.parse_finding_options(opts)

      expect(subject.confidence).to eq 80
      expect(subject.confirmed_by).to eq ['Confirmed By Test']
      expect(subject.found_by).to eq 'Found By Test'
      expect(subject.interesting_entries).to eq ['Entry 1', 'Entry 2']
      expect(subject.references).to eq(cve: ['2021-1234'], wpvulndb: ['9999'])
    end

    it 'does not set options that are not provided' do
      subject.parse_finding_options(confidence: 50)

      expect(subject.confidence).to eq 50
      expect(subject.found_by).to be_nil
    end

    it 'ignores unknown options' do
      expect { subject.parse_finding_options(unknown_option: 'test') }.not_to raise_error
    end
  end

  describe '#eql?' do
    before do
      subject.confidence = 10
      subject.found_by = 'test'
    end

    context 'when eql' do
      it 'returns true' do
        expect(subject).to eql subject
      end
    end

    context 'when not eql' do
      it 'returns false' do
        other = subject.dup
        other.confidence = 20

        expect(subject).to_not eql other
      end
    end
  end

  describe '#<=>' do
    # Handled in spec/app/models/interesting_findings_spec
  end
end
