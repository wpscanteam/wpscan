# frozen_string_literal: true

describe WPScan::Finders::Themes::UrlsInHomepage do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://wp.lab/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('themes', 'urls_in_homepage') }

  # before { target.scope << 'sub.lab' }

  it_behaves_like 'App::Finders::WpItems::UrlsInPage' do
    let(:page_url)            { url }
    let(:type)                { 'themes' }
    let(:uniq_links)          { true }
    let(:uniq_codes)          { true }
    let(:expected_from_links) { %w[dl-1] }
    let(:expected_from_codes) { %w[dc-1] }
  end

  describe '#passive' do
    before do
      stub_request(:get, finder.target.url)
        .to_return(body: File.read(fixtures.join('found.html')))

      expect(finder.target).to receive(:content_dir).at_least(1).and_return('wp-content')

      stub_request(:get, 'http://wp.lab/wp-content/themes/dl-1/style.css')
        .to_return(status: 200, body: '')
      stub_request(:get, 'http://wp.lab/wp-content/themes/dc-1/style.css')
        .to_return(status: 200, body: '')
    end

    it 'returns themes detected from links and code in the homepage' do
      themes = finder.passive

      expected_slugs = %w[dc-1 dl-1]

      expect(themes.size).to eq 2
      expect(themes.map(&:slug).sort).to eq expected_slugs.sort

      themes.each do |theme|
        expect(theme).to be_a WPScan::Model::Theme
        expect(theme.confidence).to eq 80
        expect(theme.found_by).to match(/Urls In Homepage/)
      end
    end
  end
end
