# frozen_string_literal: true

describe WPScan::Finders::InterestingFindings::UploadDirectoryListing do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url).extend(WPScan::Target::Server::Apache) }
  let(:url)        { 'http://ex.lo/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('interesting_findings', 'upload_directory_listing') }
  let(:wp_content) { 'wp-content' }

  describe '#aggressive' do
    let(:uploads_url) { 'http://ex.lo/wp-content/uploads/' }

    before do
      allow(target).to receive(:sub_dir).and_return(false)
      allow(target).to receive(:content_dir).and_return(wp_content)
    end

    context 'when directory listing is disabled' do
      before do
        expect(target).to receive(:directory_listing?).with('wp-content/uploads/').and_return(false)
      end

      it 'returns nil' do
        expect(finder.aggressive).to be nil
      end
    end

    context 'when directory listing is enabled' do
      before do
        expect(target).to receive(:directory_listing?).with('wp-content/uploads/').and_return(true)
      end

      it 'returns UploadDirectoryListing finding' do
        result = finder.aggressive

        expect(result).to be_a WPScan::Model::UploadDirectoryListing
        expect(result.url).to eq uploads_url
        expect(result.confidence).to eq 100
        expect(result.found_by).to eq 'Direct Access (Aggressive Detection)'
      end
    end
  end
end
