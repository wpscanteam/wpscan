# frozen_string_literal: true

describe WPScan::Finders::Plugins::Base do
  subject(:plugins) { described_class.new(target) }
  let(:target)      { WPScan::Target.new(url) }
  let(:url)         { 'http://ex.lo/' }

  describe '#finders' do
    it 'contains the expected finders' do
      expect(plugins.finders.map { |f| f.class.to_s.demodulize })
        .to eq %w[UrlsInHomepage UrlsIn404Page HeaderPattern Comment Xpath BodyPattern JavascriptVar KnownLocations]
    end
  end
end
