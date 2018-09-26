require 'spec_helper'

describe WPScan::Finders::InterestingFindings::BackupDB do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url).extend(CMSScanner::Target::Server::Apache) }
  let(:url)        { 'http://ex.lo/' }
  let(:fixtures)   { File.join(FINDERS_FIXTURES, 'interesting_findings', 'backup_db') }
  let(:wp_content) { 'wp-content' }
  let(:dir_url)    { target.url("#{wp_content}/backup-db/") }

  before { expect(target).to receive(:content_dir).at_least(1).and_return(wp_content) }

  describe '#aggressive' do
    before { stub_request(:get, dir_url).to_return(status: status, body: body) }

    let(:body) { '' }

    context 'when not a 200 or 403' do
      let(:status) { 404 }

      its(:aggressive) { should be_nil }
    end

    context 'when 200 and matching the homepage' do
      before { expect(target).to receive(:homepage_or_404?).and_return(true) }

      let(:status) { 200 }

      its(:aggressive) { should be_nil }
    end

    context 'when 200 or 403' do
      before { expect(target).to receive(:homepage_or_404?).and_return(false) }

      let(:status) { 200 }

      after do
        found = finder.aggressive

        expect(found).to eql WPScan::InterestingFinding.new(
          dir_url,
          confidence: 70,
          found_by: described_class::DIRECT_ACCESS
        )

        expect(found.interesting_entries).to eq @expected_entries
      end

      context 'when no directory listing' do
        it 'returns an empty interesting_findings attribute' do
          @expected_entries = []
        end
      end

      context 'when directory listing enabled' do
        let(:body) { File.read(File.join(fixtures, 'dir_listing.html')) }

        it 'returns the expected interesting_findings attribute' do
          @expected_entries = %w[sqldump.sql test.txt]
        end
      end
    end
  end
end
