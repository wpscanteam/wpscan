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
    xit
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
