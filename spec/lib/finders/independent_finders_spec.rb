# frozen_string_literal: true

require 'spec_helper'
require 'dummy_independent_finders'

describe WPScan::Finders::IndependentFinders do
  subject(:finders) { described_class.new }

  describe '#run' do
    let(:target)              { 'target' }
    let(:finding)             { WPScan::DummyFinding }
    let(:expected_aggressive) { [finding.new('test', found_by: 'override', confidence: 100)] }
    let(:expected_passive) do
      [
        finding.new('test', found_by: 'Dummy Finder (Passive Detection)'),
        finding.new('spotted', found_by: 'No Aggressive Result (Passive Detection)', confidence: 10)
      ]
    end

    before do
      finders <<
        WPScan::Finders::Independent::DummyFinder.new(target) <<
        WPScan::Finders::Independent::NoAggressiveResult.new(target)
    end

    describe 'method calls order' do
      after { finders.run(mode: mode) }

      %i[passive aggressive].each do |current_mode|
        context "when #{current_mode} mode" do
          let(:mode) { current_mode }

          it "calls the #{current_mode} method on each finder" do
            finders.each do |f|
              expect(f).to receive(current_mode).with(hash_including(found: [])).ordered
            end
          end
        end
      end

      context 'when :mixed mode' do
        let(:mode) { :mixed }
        let(:modes) { %i[passive aggressive] }

        it 'calls :passive then :aggressive on each finder' do
          finders.each do |finder|
            modes.each do |method|
              expect(finder).to receive(method).with(hash_including(found: [])).ordered
            end
          end
        end
      end
    end

    describe 'returned results' do
      before do
        @found = finders.run(mode: mode)

        expect(@found).to be_a(WPScan::Finders::Findings)

        @found.each { |f| expect(f).to be_a finding }
      end

      context 'when :passive mode' do
        let(:mode) { :passive }

        it 'returns 2 results' do
          expect(@found).to match_array(expected_passive.map { |f| eql(f) })
        end
      end

      context 'when :aggressive mode' do
        let(:mode) { :aggressive }

        it 'returns 1 result' do
          expect(@found).to match_array(expected_aggressive.map { |f| eql(f) })
        end
      end

      context 'when :mixed mode' do
        let(:mode) { :mixed }

        it 'returns 2 results' do
          first_passive = expected_passive.first.dup
          first_passive.confidence = 100

          expect(@found.size).to eq 2
          expect(@found.first).to eql first_passive
          expect(@found.first.confirmed_by).to eql expected_aggressive
          expect(@found.last).to eql expected_passive.last
        end
      end

      context 'when multiple results returned' do
        xit
      end
    end
  end
end
