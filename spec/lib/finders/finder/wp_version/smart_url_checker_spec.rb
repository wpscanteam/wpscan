# frozen_string_literal: true

describe WPScan::Finders::Finder::WpVersion::SmartURLChecker do
  # Create a minimal class that includes the module for testing
  let(:test_class) do
    Class.new do
      include WPScan::Finders::Finder::WpVersion::SmartURLChecker

      def found_by
        'Test Finder'
      end
    end
  end

  subject(:finder) { test_class.new }

  describe '#create_version' do
    context 'when version number is valid' do
      it 'creates a WpVersion with default options' do
        version = finder.create_version('3.8.1')

        expect(version).to be_a WPScan::Model::WpVersion
        expect(version.number).to eq '3.8.1'
        expect(version.found_by).to eq 'Test Finder'
        expect(version.confidence).to eq 80
      end

      it 'creates a WpVersion with custom options' do
        version = finder.create_version(
          '4.0',
          found_by: 'Custom Finder',
          confidence: 95,
          entries: ['Entry 1']
        )

        expect(version).to be_a WPScan::Model::WpVersion
        expect(version.number).to eq '4.0'
        expect(version.found_by).to eq 'Custom Finder'
        expect(version.confidence).to eq 95
        expect(version.interesting_entries).to eq ['Entry 1']
      end
    end

    context 'when version number is invalid' do
      it 'returns nil' do
        version = finder.create_version('invalid')
        expect(version).to be_nil
      end
    end
  end
end
