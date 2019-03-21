# frozen_string_literal: true

describe WPScan::Finders::WpVersion::AtomGenerator do
  subject(:finder)   { described_class.new(target) }
  let(:target)       { WPScan::Target.new(url).extend(CMSScanner::Target::Server::Apache) }
  let(:url)          { 'http://ex.lo/' }
  let(:fixtures)     { FINDERS_FIXTURES.join('wp_version', 'atom_generator') }
  let(:atom_fixture) { File.read(fixtures.join('feed', 'atom')) }

  describe '#passive, #aggressive' do
    before do
      allow(target).to receive(:sub_dir).and_return(false)

      stub_request(:get, target.url).to_return(body: File.read(homepage_fixture))
    end

    context 'when no atom links in homepage' do
      let(:homepage_fixture) { fixtures.join('no_links.html') }

      its(:passive) { should eql [] }

      it 'returns the expected from #aggressive' do
        stub_request(:get, target.url('feed/atom/')).to_return(body: atom_fixture)
        stub_request(:get, target.url('?feed=atom'))

        expect(finder.aggressive).to eql [
          WPScan::Model::WpVersion.new(
            '4.0',
            confidence: 80,
            found_by: 'Atom Generator (Aggressive Detection)',
            interesting_entries: [
              "#{target.url('feed/atom/')}, Match: '<generator uri=\"https://wordpress.org/\" version=\"4.0\">" \
              "WordPress</generator>'"
            ]
          )
        ]
      end
    end

    context 'when atom links in homepage' do
      let(:homepage_fixture) { fixtures.join('links.html') }

      it 'returns the expected from #passive' do
        stub_request(:get, target.url('?feed=atom')).to_return(body: atom_fixture)

        expect(finder.passive).to eql [
          WPScan::Model::WpVersion.new(
            '4.0',
            confidence: 80,
            found_by: 'Atom Generator (Passive Detection)',
            interesting_entries: [
              "#{target.url('?feed=atom')}, Match: '<generator uri=\"https://wordpress.org/\" version=\"4.0\">" \
              "WordPress</generator>'"
            ]
          )
        ]
      end

      context 'when :mixed mode' do
        it 'avoids checking existing URL/s from #passive' do
          stub_request(:get, target.url('feed/atom/')).to_return(body: atom_fixture)

          expect(finder.aggressive(mode: :mixed)).to eql [
            WPScan::Model::WpVersion.new(
              '4.0',
              confidence: 80,
              found_by: 'Atom Generator (Aggressive Detection)',
              interesting_entries: [
                "#{target.url('feed/atom/')}, Match: '<generator uri=\"https://wordpress.org/\" version=\"4.0\">" \
                "WordPress</generator>'"
              ]
            )
          ]
        end
      end

      context 'when no mode' do
        it 'checks all the URLs' do
          stub_request(:get, target.url('feed/atom/')).to_return(body: atom_fixture)
          stub_request(:get, target.url('?feed=atom'))

          expect(finder.aggressive).to eql [
            WPScan::Model::WpVersion.new(
              '4.0',
              confidence: 80,
              found_by: 'Atom Generator (Aggressive Detection)',
              interesting_entries: [
                "#{target.url('feed/atom/')}, Match: '<generator uri=\"https://wordpress.org/\" version=\"4.0\">" \
                "WordPress</generator>'"
              ]
            )
          ]
        end
      end
    end
  end
end
