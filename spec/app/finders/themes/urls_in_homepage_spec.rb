describe WPScan::Finders::Themes::UrlsInHomepage do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://wp.lab/' }
  let(:fixtures)   { File.join(FINDERS_FIXTURES, 'themes', 'urls_in_homepage') }

  it_behaves_like 'App::Finders::WpItems::URLsInHomepage' do
    let(:type)                { 'themes' }
    let(:uniq_links)          { true }
    let(:uniq_codes)          { true }
    let(:expected_from_links) { %w[dl-1] }
    let(:expected_from_codes) { %w[dc-1] }
  end

  describe '#passive' do
    xit
  end
end
