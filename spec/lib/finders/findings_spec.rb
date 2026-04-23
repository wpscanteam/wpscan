# frozen_string_literal: true

require 'spec_helper'
require 'dummy_finding'

describe WPScan::Finders::Findings do
  subject(:findings) { described_class.new }
  let(:finding)      { WPScan::DummyFinding }

  describe '#<<' do
    after { expect(findings).to match_array(@expected.map { |f| eql(f) }) }

    context 'when no findings already in' do
      it 'adds it' do
        findings << finding.new('empty-test', found_by: 'rspec', confidence: 20)
        @expected = [finding.new('empty-test', found_by: 'rspec', confidence: 20)]
      end
    end

    context 'when findings already in' do
      let(:confirmed) { finding.new('confirmed') }

      before { findings << nil << nil << finding.new('test') << confirmed }

      it 'adds a confirmed result correctly and ignore the nil values' do
        confirmed_dup = confirmed.dup
        confirmed_dup.confidence = 100

        findings << finding.new('test2')
        findings << confirmed_dup

        confirmed.confirmed_by = confirmed_dup

        @expected = [] << finding.new('test') << confirmed << finding.new('test2')
      end
    end
  end
end
