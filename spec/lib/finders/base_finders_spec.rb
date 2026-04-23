# frozen_string_literal: true

require 'spec_helper'
require 'dummy_independent_finders'

describe WPScan::Finders::BaseFinders do
  subject(:finders) { described_class.new }

  describe '#symbols_from_mode' do
    after { expect(finders.send(:symbols_from_mode, @mode)).to eq @expected }

    context 'when :mixed' do
      it 'returns [:passive, :aggressive]' do
        @mode     = :mixed
        @expected = %i[passive aggressive]
      end
    end

    context 'when :passive or :aggresssive' do
      %i[passive aggressive].each do |symbol|
        it 'returns it in an array' do
          @mode     = symbol
          @expected = Array(symbol)
        end
      end
    end

    context 'otherwise' do
      it 'returns []' do
        @mode     = :unallowed
        @expected = []
      end
    end
  end

  describe '#run_finder' do
    # currently handled in independent_finders_spec
  end

  describe '#findings' do
    it 'returns a Findings object' do
      expect(finders.findings).to be_a WPScan::Finders::Findings
    end
  end
end
