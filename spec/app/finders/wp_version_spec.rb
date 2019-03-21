# frozen_string_literal: true

# If this file is tested alone (rspec path-to-this-file), then there will be an error about
# constants not being intilialized. This is due to the Dynamic Finders.

describe WPScan::Finders::WpVersion::Base do
  subject(:wp_version) { described_class.new(target) }
  let(:target)         { WPScan::Target.new(url) }
  let(:url)            { 'http://ex.lo/' }

  describe '#finders' do
    let(:expected) { %w[RSSGenerator AtomGenerator RDFGenerator Readme UniqueFingerprinting] }

    let(:expected_dynamic_finders) { WPScan::DB::DynamicFinders::Wordpress.versions_finders_configs.keys }

    it 'contains the expected finders' do
      finders = wp_version.finders.map { |f| f.class.to_s.demodulize }

      expect(finders).to match_array expected + expected_dynamic_finders

      expect(finders.first).to eql 'RSSGenerator'
      expect(finders.last).to eql 'UniqueFingerprinting'
    end
  end
end
