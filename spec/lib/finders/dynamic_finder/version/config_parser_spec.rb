# frozen_string_literal: true

describe WPScan::Finders::DynamicFinder::Version::ConfigParser do
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
  let(:finder_class)  { WPScan::Finders::Version::Rspec::ConfigParser }
  let(:finder_config) { { 'key' => 'some-key', 'path' => 'file.json' } }
  let(:default)       { { 'pattern' => /(?<v>\d+\.[.\d]+)/, 'confidence' => 70 } }

  before { described_class.create_child_class(finder_module, :ConfigParser, finder_config) }
  after  { finder_module.send(:remove_const, :ConfigParser) }

  describe '.create_child_class' do
    context 'when CONFIDENCE' do
      let(:finder_config) { super().merge('confidence' => 30) }

      it 'contains the expected constants' do
        expect(finder_class::KEY).to eql finder_config['key']
        expect(finder_class::CONFIDENCE).to eql finder_config['confidence']
        expect(finder_class::PATH).to eql finder_config['path']

        expect(finder_class::PATTERN).to eql default['pattern']
      end
    end

    context 'when PATTERN' do
      let(:finder_config) { super().merge('pattern' => /another pattern/i) }

      it 'contains the expected constants' do
        expect(finder_class::KEY).to eql finder_config['key']
        expect(finder_class::PATTERN).to eql finder_config['pattern']
        expect(finder_class::PATH).to eql finder_config['path']

        expect(finder_class::CONFIDENCE).to eql default['confidence']
      end
    end
  end

  describe '#passive, #aggressive' do
    # Handled in spec/lib/finders/dynamic_finder/plugin_version_spec
  end
end
