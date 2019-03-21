# frozen_string_literal: true

describe WPScan::DB::Fingerprints do
  describe '#unique_fingerprints' do
    # Handled in #wp_unique_fingerprints
  end

  describe '.wp_fingerprints' do
    it 'returns the expected value' do
      expect(described_class.wp_fingerprints).to eql(
        'path-1' => {
          'hash-1' => %w[4.0 3.8],
          'hash-2' => ['4.4']
        },
        'path-2' => {
          'hash-3' => %w[3.8.1 3.8.2 3.9.1]
        }
      )
    end
  end

  describe '.wp_unique_fingerprints' do
    it 'returns the expected value' do
      expect(described_class.wp_unique_fingerprints).to eql('path-1' => { 'hash-2' => '4.4' })
    end
  end
end
