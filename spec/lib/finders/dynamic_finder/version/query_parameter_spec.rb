# frozen_string_literal: true

describe WPScan::Finders::DynamicFinder::Version::QueryParameter do
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
  let(:finder_class)  { WPScan::Finders::Version::Rspec::QueryParameter }
  let(:finder_config) { { 'files' => %w[f1 f2] } }
  let(:default) { { 'pattern' => /(?:v|ver|version)\=(?<v>\d+\.[\.\d]+)/i, 'confidence_per_occurence' => 10 } }

  before { described_class.create_child_class(finder_module, :QueryParameter, finder_config) }
  after  { finder_module.send(:remove_const, :QueryParameter) }

  describe '.create_child_class' do
    context 'when no XPATH, PATTERN and CONFIDENCE_PER_OCCURENCE ' do
      it 'contains the expected constants to their default values' do
        expect(finder_class::FILES).to eql finder_config['files']

        expect(finder_class::PATTERN).to eql default['pattern']
        expect(finder_class::CONFIDENCE_PER_OCCURENCE).to eql default['confidence_per_occurence']
        expect(finder_class::XPATH).to eql nil
        expect(finder_class::PATH).to eql nil
      end
    end

    context 'when XPATH' do
      let(:finder_config) { super().merge('xpath' => '//xpath') }

      it 'contains the expected constants' do
        expect(finder_class::FILES).to eql finder_config['files']
        expect(finder_class::XPATH).to eql finder_config['xpath']

        expect(finder_class::CONFIDENCE_PER_OCCURENCE).to eql default['confidence_per_occurence']
        expect(finder_class::PATTERN).to eql default['pattern']
        expect(finder_class::PATH).to eql nil
      end
    end

    context 'when PATTERN' do
      let(:finder_config) { super().merge('pattern' => /pattern/i) }

      it 'contains the expected constants' do
        expect(finder_class::FILES).to eql finder_config['files']
        expect(finder_class::PATTERN).to eql finder_config['pattern']

        expect(finder_class::CONFIDENCE_PER_OCCURENCE).to eql default['confidence_per_occurence']
        expect(finder_class::XPATH).to eql nil
        expect(finder_class::PATH).to eql nil
      end
    end

    context 'when CONFIDENCE_PER_OCCURENCE' do
      let(:finder_config) { super().merge('confidence_per_occurence' => 30) }

      it 'contains the expected constants' do
        expect(finder_class::FILES).to eql finder_config['files']
        expect(finder_class::CONFIDENCE_PER_OCCURENCE).to eql finder_config['confidence_per_occurence']

        expect(finder_class::PATTERN).to eql default['pattern']
        expect(finder_class::XPATH).to eql nil
        expect(finder_class::PATH).to eql nil
      end
    end

    context 'when PATH' do
      let(:finder_config) { super().merge('path' => 'file.html') }

      it 'contains the expected constants' do
        expect(finder_class::FILES).to eql finder_config['files']
        expect(finder_class::PATH).to eql finder_config['path']

        expect(finder_class::CONFIDENCE_PER_OCCURENCE).to eql default['confidence_per_occurence']
        expect(finder_class::XPATH).to eql nil
        expect(finder_class::PATTERN).to eql default['pattern']
      end
    end
  end

  describe '#passive, #aggressive' do
    # Handled in spec/lib/finders/dynamic_finder/plugin_version_spec
  end
end
