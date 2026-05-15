# frozen_string_literal: true

describe WPScan::Finders::WpVersion::RSSGenerator do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url).extend(WPScan::Target::Server::Apache) }
  let(:url)        { 'http://ex.lo/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('wp_version', 'rss_generator') }
  let(:rss_fixture) { File.read(fixtures.join('feed', 'rss')) }

  describe '#passive, #aggressive' do
    before do
      allow(target).to receive(:sub_dir).and_return(false)

      stub_request(:get, target.url).to_return(body: File.read(homepage_fixture))
    end

    context 'when no rss links in homepage' do
      let(:homepage_fixture) { fixtures.join('no_links.html') }

      its(:passive) { should eql [] }

      it 'returns the expected from #aggressive' do
        stub_request(:get, target.url('feed/')).to_return(body: rss_fixture)
        stub_request(:get, target.url('comments/feed/'))
        stub_request(:get, target.url('feed/rss/'))
        stub_request(:get, target.url('feed/rss2/'))

        expect(finder.aggressive).to eql [
          WPScan::Model::WpVersion.new(
            '4.0',
            confidence: 80,
            found_by: 'Rss Generator (Aggressive Detection)',
            interesting_entries: [
              "#{target.url('feed/')}, <generator>https://wordpress.org/?v=4.0</generator>"
            ]
          )
        ]
      end
    end

    context 'when rss links in homepage' do
      let(:homepage_fixture) { fixtures.join('links.html') }

      it 'returns the expected from #passive' do
        stub_request(:get, 'http://ex.lo/feed/').to_return(body: rss_fixture)

        expect(finder.passive).to eql [
          WPScan::Model::WpVersion.new(
            '4.0',
            confidence: 80,
            found_by: 'Rss Generator (Passive Detection)',
            interesting_entries: [
              'http://ex.lo/feed/, <generator>https://wordpress.org/?v=4.0</generator>'
            ]
          )
        ]
      end

      context 'when :mixed mode' do
        it 'avoids checking existing URL/s from #passive' do
          stub_request(:get, target.url('comments/feed/')).to_return(body: rss_fixture)
          stub_request(:get, target.url('feed/rss/')).to_return(body: rss_fixture)
          stub_request(:get, target.url('feed/rss2/')).to_return(body: rss_fixture)

          results = finder.aggressive(mode: :mixed)
          expect(results.size).to be >= 1
          expect(results.first.number).to eql '4.0'
        end
      end

      context 'when no mode' do
        it 'checks all the URLs' do
          stub_request(:get, target.url('feed/')).to_return(body: rss_fixture)
          stub_request(:get, target.url('comments/feed/')).to_return(body: rss_fixture)
          stub_request(:get, target.url('feed/rss/')).to_return(body: rss_fixture)
          stub_request(:get, target.url('feed/rss2/')).to_return(body: rss_fixture)

          results = finder.aggressive
          expect(results.size).to be >= 1
          expect(results.first.number).to eql '4.0'
        end
      end
    end
  end
end
