# frozen_string_literal: true

describe WPScan::Finders::InterestingFindings::PluginBackupFolders do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url).extend(CMSScanner::Target::Server::Apache) }
  let(:url)        { 'http://ex.lo/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('interesting_findings', 'plugin_backup_folders') }

  before do
    expect(target).to receive(:content_dir).at_least(1).and_return('wp-content')

    finder.class::PATHS.each { |path| stub_request(:head, target.url(path)).to_return(status: 404) }

    allow(target).to receive(:head_or_get_params).and_return(method: :head)
  end

  describe '#aggressive' do
    context 'when none of them exist' do
      it 'returns an empty array' do
        expect(finder.aggressive).to eql([])
      end
    end

    context 'when one exist but matches the homepage' do
      let(:existing_url) { target.url(finder.class::PATHS.sample) }

      it 'ignores it' do
        stub_request(:head, existing_url)
        stub_request(:get, existing_url)

        expect(target).to receive(:homepage_or_404?).and_return(true)

        expect(finder.aggressive).to eql([])
      end
    end

    context 'when 200 or 403' do
      let(:existing_url) { target.url(finder.class::PATHS.sample) }

      before do
        stub_request(:head, existing_url)
        stub_request(:get, existing_url).and_return(body: body)

        expect(target).to receive(:homepage_or_404?).and_return(false)
      end

      after do
        found = finder.aggressive

        expect(found.size).to eql 1

        expect(found).to eql([WPScan::Model::PluginBackupFolder.new(existing_url,
                                                                    confidence: 70,
                                                                    found_by: described_class::DIRECT_ACCESS)])

        expect(found.first.interesting_entries).to eq @expected_entries
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
