# frozen_string_literal: true

require 'spec_helper'
require 'dummy_unique_finders'

describe WPScan::Finders::UniqueFinders do
  subject(:finders)    { described_class.new }
  let(:unique_finders) { WPScan::Finders::Unique }

  describe '#filter_finding' do
    let(:findings) { [] }

    after do
      finders.instance_variable_set(:@findings, findings)

      expect(finders.send(:filter_findings)).to eql @expected
    end

    context 'when no findings' do
      it 'returns false' do
        @expected = false
      end
    end

    context 'when one finding' do
      let(:findings) { [WPScan::DummyFinding.new('one', confidence: 40)] }

      it 'returns it' do
        @expected = findings[0]
      end
    end

    context 'when multiple findings' do
      let(:findings) do
        (1..5).reduce([]) { |acc, elem| acc << WPScan::DummyFinding.new(elem, confidence: 20) }
      end

      context 'when they have the same confidence' do
        it 'returns false' do
          @expected = false
        end
      end

      context 'when there is a best confidence' do
        (0..4).each do |position|
          context "when at [#{position}]" do
            it 'returns it' do
              findings[position].confidence = 100

              @expected = findings[position]
            end
          end
        end
      end
    end
  end

  describe '#run' do
    let(:target)  { 'target' }
    let(:finding) { WPScan::DummyFinding }
    let(:opts)    { {} }

    before do
      finders <<
        unique_finders::Dummy.new(target) <<
        unique_finders::NoAggressive.new(target) <<
        unique_finders::Dummy2.new(target)
    end

    after do
      result = finders.run(opts)

      expect(result).to be_a finding if @expected
      expect(result).to eql @expected
    end

    let(:dummy_passive)     { unique_finders::Dummy.new(target).passive(opts) }
    let(:dummy_aggresssive) { unique_finders::Dummy.new(target).aggressive(opts) }
    let(:noaggressive)      { unique_finders::NoAggressive.new(target).passive(opts) }
    let(:dummy2_aggressive) { unique_finders::Dummy2.new(target).aggressive }

    context 'when :confidence_threshold <= 0' do
      let(:opts) { super().merge(confidence_threshold: 0) }

      context 'when :mixed mode' do
        let(:opts) { super().merge(mode: :mixed) }

        it 'calls all #passive then #aggressive on finders and returns the best result' do
          expect(finders[0]).to receive(:passive)
            .with(hash_including(found: [])).ordered.and_call_original

          expect(finders[1]).to receive(:passive)
            .with(hash_including(found: [dummy_passive.first])).ordered.and_call_original

          expect(finders[2]).to receive(:passive)
            .with(hash_including(found: [dummy_passive.first, noaggressive])).ordered

          expect(finders[0]).to receive(:aggressive).with(hash_including(:found)).ordered
                                                    .and_call_original

          expect(finders[1]).to receive(:aggressive).with(hash_including(:found)).ordered
          expect(finders[2]).to receive(:aggressive).with(hash_including(:found)).ordered
                                                    .and_call_original

          @expected = finding.new('v1', confidence: 100, found_by: 'Dummy (Passive Detection)')
          @expected.confirmed_by << finding.new('v1', confidence: 100, found_by: 'override')
          @expected.confirmed_by << finding.new('v1', confidence: 90)
        end
      end

      context 'when :passive mode' do
        let(:opts) { super().merge(mode: :passive) }

        it 'calls #passive on all finders and returns the best result' do
          expect(finders[0]).to receive(:passive)
            .with(hash_including(found: [])).ordered.and_call_original

          expect(finders[1]).to receive(:passive)
            .with(hash_including(found: [dummy_passive.first])).ordered.and_call_original

          expect(finders[2]).to receive(:passive)
            .with(hash_including(found: [dummy_passive.first, noaggressive])).ordered

          finders.each { |f| expect(f).to_not receive(:aggressive) }

          @expected = finding.new('v2', confidence: 10,
                                        found_by: 'No Aggressive (Passive Detection)')
        end
      end

      context 'when :aggressive mode' do
        let(:opts) { super().merge(mode: :aggressive) }

        it 'calls #aggressive on all finders and returns the best result' do
          finders.each { |f| expect(f).to_not receive(:passive) }

          expect(finders[0]).to receive(:aggressive)
            .with(hash_including(found: [])).ordered.and_call_original

          expect(finders[1]).to receive(:aggressive)
            .with(hash_including(found: [dummy_aggresssive])).ordered

          expect(finders[2]).to receive(:aggressive)
            .with(hash_including(:found)).ordered.and_call_original

          @expected = finding.new('v1', confidence: 100, found_by: 'override')
          @expected.confirmed_by << finding.new('v1', confidence: 90)
        end
      end
    end

    context 'when :confidence_threshold = 100 (default)' do
      context 'when :mixed mode' do
        let(:opts) { super().merge(mode: :mixed) }

        it 'calls all #passive then #aggressive methods on finders and returns the ' \
           'result which reaches 100% confidence during the process' do
          expect(finders[0]).to receive(:passive)
            .with(hash_including(found: [])).ordered.and_call_original

          expect(finders[1]).to receive(:passive)
            .with(hash_including(found: [dummy_passive.first])).ordered.and_call_original

          expect(finders[2]).to receive(:passive)
            .with(hash_including(found: [dummy_passive.first, noaggressive])).ordered

          expect(finders[0]).to receive(:aggressive).with(hash_including(:found)).ordered
                                                    .and_call_original

          expect(finders[1]).to_not receive(:aggressive)
          expect(finders[2]).to_not receive(:aggressive)

          @expected = finding.new('v1', confidence: 100, found_by: 'Dummy (Passive Detection)')
          @expected.confirmed_by << finding.new('v1', confidence: 100, found_by: 'override')
        end
      end

      context 'when :passive mode' do
        let(:opts) { super().merge(mode: :passive) }

        it 'calls all #passive and returns the best result' do
          expect(finders[0]).to receive(:passive)
            .with(hash_including(found: [])).ordered.and_call_original

          expect(finders[1]).to receive(:passive)
            .with(hash_including(found: [dummy_passive.first])).ordered.and_call_original

          expect(finders[2]).to receive(:passive)
            .with(hash_including(found: [dummy_passive.first, noaggressive])).ordered

          finders.each { |f| expect(f).to_not receive(:aggressive) }

          @expected = finding.new('v2', confidence: 10,
                                        found_by: 'No Aggressive (Passive Detection)')
        end
      end

      context 'when :aggressive mode' do
        let(:opts) { super().merge(mode: :aggressive) }

        it 'calls all #aggressive and returns the result which reaches 100% confidence' do
          finders.each { |f| expect(f).to_not receive(:passive) }

          expect(finders[0]).to receive(:aggressive)
            .with(hash_including(found: [])).ordered.and_call_original

          expect(finders[1]).to_not receive(:aggressive)
          expect(finders[2]).to_not receive(:aggressive)

          @expected = finding.new('v1', confidence: 100, found_by: 'override')
        end
      end
    end
  end
end
