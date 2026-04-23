# frozen_string_literal: true

describe WPScan::Model::Version do
  it_behaves_like WPScan::Finders::Finding

  subject(:version) { described_class.new(number, opts) }
  let(:opts)        { {} }
  let(:number)      { '1.0' }

  its(:to_s)        { should eql '1.0' }

  describe '#number' do
    its(:number) { should eql '1.0' }

    context 'when float number supplied' do
      let(:number) { 2.0 }

      its(:number) { should eql '2.0' }
      its(:to_s)   { should eql '2.0' }
    end

    context 'when starting with a dot' do
      let(:number) { '.2' }

      its(:number) { should eql '0.2' }
    end
  end

  describe '#<=>, #==, #>, #<' do
    it 'returns true' do
      expect(version == '1.0').to be true
      expect(version == 1.0).to be true # rubocop:disable Lint/FloatComparison
      expect(version == described_class.new('1.0')).to be true
      expect(version > '0.9').to be true
      expect(version < '2').to be true

      expect(described_class.new('0.1') == '.1').to be true
      expect(described_class.new('.1') == '0.1').to be true
    end

    it 'returns false' do
      expect(version == '2.0').to be false
      expect(version == described_class.new('2')).to be false
      expect(version > '2.0').to be false
      expect(version < '1.0').to be false

      expect(version < 'gg').to be false
      expect(version == '').to be false
      expect(version == true).to be false
    end
  end
end
