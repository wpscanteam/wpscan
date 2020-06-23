# frozen_string_literal: true

describe WPScan::Finders::DynamicFinder::Version::Comment do
  module WPScan
    module Finders
      module Version
        # Needed to be able to test the below
        module Rspec
        end
      end
    end
  end

  let(:finder_module) { WPScan::Finders::Version::Rspec }
  let(:finder_class)  { WPScan::Finders::Version::Rspec::Comment }
  let(:finder_config) { { 'pattern' => /some version: (?<v>[\d.]+)/i } }
  let(:default)       { { 'xpath' => '//comment()', 'confidence' => 60 } }

  before { described_class.create_child_class(finder_module, :Comment, finder_config) }
  after  { finder_module.send(:remove_const, :Comment) }

  describe '.create_child_class' do
    context 'when no PATH and CONFIDENCE' do
      it 'contains the expected constants to their default values' do
        # Doesn't work, dunno why
        # expect(finder_module.const_get(:Comment)).to be_a described_class
        # expect(finder_class.is_a?(described_class)).to eql true
        # expect(finder_class).to be_a described_class

        expect(finder_class::PATTERN).to eql finder_config['pattern']

        expect(finder_class::XPATH).to eql default['xpath']
        expect(finder_class::CONFIDENCE).to eql default['confidence']
        expect(finder_class::PATH).to eql nil
      end
    end

    context 'when CONFIDENCE' do
      let(:finder_config) { super().merge('confidence' => 30) }

      it 'contains the expected constants' do
        expect(finder_class::PATTERN).to eql finder_config['pattern']
        expect(finder_class::CONFIDENCE).to eql finder_config['confidence']

        expect(finder_class::XPATH).to eql default['xpath']
        expect(finder_class::PATH).to eql nil
      end
    end

    context 'when PATH' do
      let(:finder_config) { super().merge('path' => 'file.txt') }

      it 'contains the expected constants' do
        expect(finder_class::PATTERN).to eql finder_config['pattern']
        expect(finder_class::PATH).to eql finder_config['path']

        expect(finder_class::CONFIDENCE).to eql default['confidence']
        expect(finder_class::XPATH).to eql default['xpath']
      end
    end

    context 'when XPATH' do
      let(:finder_config) { super().merge('xpath' => '//comment()[contains(. "aa")]') }

      it 'contains the expected constants' do
        expect(finder_class::PATTERN).to eql finder_config['pattern']
        expect(finder_class::XPATH).to eql finder_config['xpath']

        expect(finder_class::PATH).to eql nil
        expect(finder_class::CONFIDENCE).to eql default['confidence']
      end
    end
  end

  describe '#passive, #aggressive' do
    # Handled in spec/lib/finders/dynamic_finder/plugin_version_spec
  end
end
