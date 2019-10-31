# frozen_string_literal: true

describe WPScan::Finders::MainTheme::Base do
  subject(:main_theme) { described_class.new(target) }
  let(:target)         { WPScan::Target.new(url) }
  let(:url)            { 'http://ex.lo/' }

  describe '#finders' do
    it 'contains the expected finders' do
      expect(main_theme.finders.map { |f| f.class.to_s.demodulize })
        .to eq %w[CssStyleInHomepage CssStyleIn404Page WooFrameworkMetaGenerator UrlsInHomepage UrlsIn404Page]
    end
  end
end
