# frozen_string_literal: true

describe WPScan::Finders::Plugins::UrlsInHomepage do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'https://wp.lab/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('plugins', 'urls_in_homepage') }

  before { target.scope << 'sub.lab' }

  it_behaves_like 'App::Finders::WpItems::UrlsInPage' do
    let(:page_url)            { url }
    let(:type)                { 'plugins' }
    let(:uniq_links)          { true }
    let(:uniq_codes)          { true }
    let(:expected_from_links) { (1..5).map { |i| "dl-#{i}" } }
    let(:expected_from_codes) { (1..6).map { |i| "dc-#{i}" } }
  end

  describe '#passive' do
    before do
      stub_request(:get, finder.target.url)
        .to_return(body: File.read(fixtures.join('found.html')))

      expect(finder.target).to receive(:content_dir).at_least(1).and_return('wp-content')
    end

    xit
  end
end
