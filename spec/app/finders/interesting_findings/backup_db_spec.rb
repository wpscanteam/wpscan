# frozen_string_literal: true

describe WPScan::Finders::InterestingFindings::BackupDB do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url).extend(CMSScanner::Target::Server::Apache) }
  let(:url)        { 'http://ex.lo/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('interesting_findings', 'backup_db') }
  let(:wp_content) { 'wp-content' }
  let(:dir_url)    { target.url("#{wp_content}/backup-db/") }

  before do
    expect(target).to receive(:content_dir).at_least(1).and_return(wp_content)
    expect(target).to receive(:head_or_get_params).and_return(method: :head)
  end

  describe '#aggressive' do
    context 'when not a 200 or 403' do
      it 'returns nil' do
        stub_request(:head, dir_url).to_return(status: 404)

        expect(finder.aggressive).to eql nil
      end
    end

    context 'when 200 and matching the homepage' do
      it 'returns nil' do
        stub_request(:head, dir_url)
        stub_request(:get, dir_url)

        expect(target).to receive(:homepage_or_404?).and_return(true)

        expect(finder.aggressive).to eql nil
      end
    end

    context 'when 200 or 403' do
      before do
        stub_request(:head, dir_url)
        stub_request(:get, dir_url).and_return(body: body)

        expect(target).to receive(:homepage_or_404?).and_return(false)
      end

      after do
        found = finder.aggressive

        expect(found).to eql WPScan::Model::BackupDB.new(
          dir_url,
          confidence: 70,
          found_by: described_class::DIRECT_ACCESS
        )

        expect(found.interesting_entries).to eq @expected_entries
      end

      context 'when no directory listing' do
        let(:body) { '' }

        it 'returns an empty interesting_findings attribute' do
          @expected_entries = []
        end
      end

      context 'when directory listing enabled' do
        let(:body) { File.read(fixtures.join('dir_listing.html')) }

        it 'returns the expected interesting_findings attribute' do
          @expected_entries = %w[sqldump.sql test.txt]
        end
      end
    end
  end
end
