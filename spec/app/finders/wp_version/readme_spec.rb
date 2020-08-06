# frozen_string_literal: true

describe WPScan::Finders::WpVersion::Readme do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url).extend(CMSScanner::Target::Server::Apache) }
  let(:url)        { 'http://ex.lo/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('wp_version', 'readme') }
  let(:readme_url) { "#{url}readme.html" }

  describe '#aggressive' do
    before { stub_request(:get, readme_url).to_return(body: File.read(fixtures.join(file))) }

    after do
      expect(target).to receive(:sub_dir).and_return(false)
      expect(finder.aggressive).to eql @expected
    end

    context 'when no version' do
      let(:file) { 'no_version.html' }

      it 'returns nil' do
        @expected = nil
      end
    end

    context 'when invalid version number' do
      let(:file) { 'invalid.html' }

      it 'returns nil' do
        @expected = nil
      end
    end

    context 'when present and valid' do
      let(:file) { '4.0.html' }

      it 'returns the expected version' do
        @expected = WPScan::Model::WpVersion.new(
          '4.0',
          confidence: 90,
          found_by: 'Readme (Aggressive Detection)',
          interesting_entries: [
            "#{readme_url}, Match: 'Version 4.0'"
          ]
        )
      end
    end
  end
end
