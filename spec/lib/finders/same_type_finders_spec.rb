# frozen_string_literal: true

require 'spec_helper'
require 'dummy_independent_finders'

describe WPScan::Finders::SameTypeFinders do
  subject(:finders) { described_class.new }
  let(:independent_finders) { WPScan::Finders::Independent }

  describe '#run' do
    let(:target)  { 'target' }
    let(:finding) { WPScan::DummyFinding }
    let(:opts)    { {} }

    before do
      finders <<
        independent_finders::DummyFinder.new(target) <<
        independent_finders::NoAggressiveResult.new(target)
    end

    after do
      result = finders.run(opts)

      expect(result).to be_a WPScan::Finders::Findings
      expect(result).to match_array(@expected.map { |f| eql(f) })
    end

    let(:dummy_passive)     { independent_finders::DummyFinder.new(target).passive(opts) }
    let(:dummy_aggresssive) { independent_finders::DummyFinder.new(target).aggressive(opts) }
    let(:noaggressive)      { independent_finders::NoAggressiveResult.new(target).passive(opts) }

    context 'when :mixed mode' do
      let(:opts) { super().merge(mode: :mixed) }

      it 'calls all #passive then #aggressive on finders and returns the results' do
        expect(finders[0]).to receive(:passive)
          .with(hash_including(found: [])).ordered.and_call_original

        expect(finders[1]).to receive(:passive)
          .with(hash_including(found: [dummy_passive.first])).ordered.and_call_original

        expect(finders[0]).to receive(:aggressive)
          .with(hash_including(found: [dummy_passive.first, noaggressive]))
          .ordered.and_call_original

        expect(finders[1]).to receive(:aggressive)
          .with(hash_including(:found))
          .ordered

        @expected = []

        @expected << finding.new('test', confidence: 100,
                                         found_by: 'Dummy Finder (Passive Detection)')

        @expected.first.confirmed_by << finding.new('test', confidence: 100, found_by: 'override')

        @expected << finding.new('spotted', confidence: 10,
                                            found_by: 'No Aggressive Result (Passive Detection)')
      end
    end

    context 'when :passive mode' do
      let(:opts) { super().merge(mode: :passive) }

      before do
        expect(finders[0]).to receive(:passive)
          .with(hash_including(found: [])).ordered.and_call_original

        expect(finders[1]).to receive(:passive)
          .with(hash_including(found: [dummy_passive.first])).ordered.and_call_original

        finders.each { |f| expect(f).to_not receive(:aggressive) }
      end

      it 'calls #passive on all finders and returns the results' do
        @expected = []
        @expected << finding.new('test', found_by: 'Dummy Finder (Passive Detection)')
        @expected << finding.new('spotted', confidence: 10,
                                            found_by: 'No Aggressive Result (Passive Detection)')
      end

      context 'when :sort used' do
        let(:opts) { super().merge(sort: true) }

        it 'returns the sorted results' do
          @expected = []
          @expected << finding.new('spotted', confidence: 10,
                                              found_by: 'No Aggressive Result (Passive Detection)')
          @expected << finding.new('test', found_by: 'Dummy Finder (Passive Detection)')
        end
      end
    end

    context 'when :aggressive mode' do
      let(:opts) { super().merge(mode: :aggressive) }

      it 'calls #aggressive on all finders and returns the results' do
        finders.each { |f| expect(f).to_not receive(:passive) }

        expect(finders[0]).to receive(:aggressive)
          .with(hash_including(found: [])).ordered.and_call_original

        expect(finders[1]).to receive(:aggressive)
          .with(hash_including(found: [dummy_aggresssive])).ordered

        @expected = [finding.new('test', confidence: 100, found_by: 'override')]
      end
    end
  end
end
