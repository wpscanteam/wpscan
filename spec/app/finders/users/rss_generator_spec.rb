# frozen_string_literal: true

describe WPScan::Finders::Users::RSSGenerator do
  subject(:finder)  { described_class.new(target) }
  let(:target)      { WPScan::Target.new(url) }
  let(:url)         { 'http://ex.lo/' }
  let(:fixtures)    { FINDERS_FIXTURES.join('users', 'rss_generator') }
  let(:rss_fixture) { File.read(fixtures.join('feed.xml')) }

  describe '#passive, #aggressive' do
    before do
      allow(target).to receive(:sub_dir).and_return(false)

      stub_request(:get, target.url).to_return(body: File.read(homepage_fixture))
    end

    context 'when no RSS link in homepage' do
      let(:homepage_fixture) { fixtures.join('homepage_no_links.html') }

      its(:passive) { should eql [] }

      it 'returns the expected from #aggressive' do
        stub_request(:get, target.url('feed/')).to_return(body: rss_fixture)
        stub_request(:get, target.url('comments/feed/'))
        stub_request(:get, target.url('feed/rss/'))
        stub_request(:get, target.url('feed/rss2/'))

        expect(finder.aggressive).to eql [
          WPScan::Model::User.new(
            'admin',
            confidence: 50,
            found_by: 'Rss Generator (Aggressive Detection)'
          ),
          WPScan::Model::User.new(
            'Aa Dias-Gildes',
            confidence: 50,
            found_by: 'Rss Generator (Aggressive Detection)'
          )
        ]
      end
    end

    context 'when RSS link in homepage' do
      let(:homepage_fixture) { fixtures.join('homepage_links.html') }

      it 'returns the expected from #passive' do
        stub_request(:get, target.url('feed/')).to_return(body: rss_fixture)

        expect(finder.passive).to eql [
          WPScan::Model::User.new(
            'admin',
            confidence: 50,
            found_by: 'Rss Generator (Passive Detection)'
          ),
          WPScan::Model::User.new(
            'Aa Dias-Gildes',
            confidence: 50,
            found_by: 'Rss Generator (Passive Detection)'
          )
        ]
      end

      context 'when :mixed mode' do
        it 'avoids checking existing URL/s from #passive' do
          stub_request(:get, target.url('comments/feed/')).to_return(body: rss_fixture)

          expect(finder.aggressive(mode: :mixed)).to eql [
            WPScan::Model::User.new(
              'admin',
              confidence: 50,
              found_by: 'Rss Generator (Aggressive Detection)'
            ),
            WPScan::Model::User.new(
              'Aa Dias-Gildes',
              confidence: 50,
              found_by: 'Rss Generator (Aggressive Detection)'
            )
          ]
        end
      end

      context 'when no mode' do
        it 'checks the first URL detected from the URLs' do
          stub_request(:get, target.url('feed/')).to_return(body: rss_fixture)

          expect(finder.aggressive).to eql [
            WPScan::Model::User.new(
              'admin',
              confidence: 50,
              found_by: 'Rss Generator (Aggressive Detection)'
            ),
            WPScan::Model::User.new(
              'Aa Dias-Gildes',
              confidence: 50,
              found_by: 'Rss Generator (Aggressive Detection)'
            )
          ]
        end
      end
    end
  end
end
