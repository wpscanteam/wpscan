# frozen_string_literal: true

describe WPScan::Finders::Plugins::HeaderPattern do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://wp.lab/' }
  let(:fixtures)   { DYNAMIC_FINDERS_FIXTURES.join('plugin_version') }

  def plugin(slug)
    WPScan::Model::Plugin.new(slug, target)
  end

  describe '#passive' do
    after do
      stub_request(:get, target.url).to_return(headers: headers)

      found = finder.passive

      expect(found).to match_array @expected
      expect(found.first.found_by).to eql 'Header Pattern (Passive Detection)' unless found.empty?
    end

    context 'when empty headers' do
      let(:headers) { {} }

      it 'returns an empty array' do
        @expected = []
      end
    end

    context 'when headers' do
      before { expect(target).to receive(:content_dir).and_return('wp-content') }

      let(:headers) { JSON.parse(File.read(fixtures.join('header_pattern_passive_all.html'))) }

      it 'returns the expected plugins' do
        @expected = []

        WPScan::DB::DynamicFinders::Plugin.passive_header_pattern_finder_configs.each_key do |slug|
          @expected << plugin(slug)
        end
      end
    end
  end
end
