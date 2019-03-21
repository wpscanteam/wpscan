# frozen_string_literal: true

describe WPScan::Finders::InterestingFindings::UploadDirectoryListing do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url).extend(CMSScanner::Target::Server::Apache) }
  let(:url)        { 'http://ex.lo/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('interesting_findings', 'upload_directory_listing') }
  let(:wp_content) { 'wp-content' }

  describe '#aggressive' do
    xit
  end
end
