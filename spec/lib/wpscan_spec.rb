# frozen_string_literal: true

describe WPScan do
  it 'has a version number' do
    expect(WPScan::VERSION).not_to be nil
  end

  describe '#app_name' do
    it 'returns the overriden string' do
      expect(WPScan.app_name).to eql 'wpscan'
    end
  end
end
