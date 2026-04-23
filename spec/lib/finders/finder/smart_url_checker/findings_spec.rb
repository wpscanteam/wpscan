# frozen_string_literal: true

require 'spec_helper'
require 'dummy_finding'

describe WPScan::Finders::Finder::SmartURLChecker::Findings do
  subject(:findings) { described_class.new }
  let(:finding)      { WPScan::DummyFinding }

  describe '#<<' do
    after { expect(findings).to match_array(@expected.map { |f| eql(f) }) }

    context 'when no findings already in' do
      it 'adds it' do
        findings << finding.new('empty-test')
        @expected = [finding.new('empty-test')]
      end
    end

    context 'when findings already in' do
      let(:confirmed) { finding.new('confirmed', interesting_entries: entries) }
      let(:entries)   { %w[e1 e2] }

      before { findings << nil << nil << finding.new('test') << confirmed }

      it 'adds a confirmed result correctly and ignore nil values' do
        confirmed_dup = confirmed.dup
        confirmed_dup.confidence = 100
        confirmed_dup.interesting_entries = %w[e2 e3]

        findings << confirmed_dup

        confirmed.confirmed_by = confirmed_dup

        @expected = [] << finding.new('test') << confirmed

        expect(findings[1].interesting_entries).to eql(%w[e1 e2 e3])
      end
    end
  end
end
