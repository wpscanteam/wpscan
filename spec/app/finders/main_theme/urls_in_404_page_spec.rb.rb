# frozen_string_literal: true

describe WPScan::Finders::MainTheme::UrlsIn404Page do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://wp.lab/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('main_theme', 'urls_in_404_page') }

  # This stuff is just a child class of URLsInHomepage (using the error_404_res rather than homepage_res)
  # which already has a spec
end
