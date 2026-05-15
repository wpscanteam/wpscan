# frozen_string_literal: true

describe WPScan::Finders::WpVersion::RDFGenerator do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url).extend(WPScan::Target::Server::Apache) }
  let(:url)        { 'http://ex.lo/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('wp_version', 'rdf_generator') }
  let(:rdf_fixture) { File.read(fixtures.join('feed', 'rdf')) }

  describe '#passive, #aggressive' do
    before do
      allow(target).to receive(:sub_dir).and_return(false)

      stub_request(:get, target.url).to_return(body: File.read(homepage_fixture))
    end

    context 'when no rdf links in homepage' do
      let(:homepage_fixture) { fixtures.join('no_links.html') }

      its(:passive) { should eql [] }

      it 'returns the expected from #aggressive' do
        stub_request(:get, target.url('feed/rdf/')).to_return(body: rdf_fixture)

        expect(finder.aggressive).to eql [
          WPScan::Model::WpVersion.new(
            '4.0',
            confidence: 80,
            found_by: 'Rdf Generator (Aggressive Detection)',
            interesting_entries: [
              "#{target.url('feed/rdf/')}, <generatoragent rdf:resource=\"https://wordpress.org/?v=4.0\"></generatoragent>"
            ]
          )
        ]
      end
    end

    context 'when rdf links in homepage' do
      let(:homepage_fixture) { fixtures.join('links.html') }

      it 'returns the expected from #passive' do
        stub_request(:get, 'http://ex.lo/feed/rdf/').to_return(body: rdf_fixture)

        expect(finder.passive).to eql [
          WPScan::Model::WpVersion.new(
            '4.0',
            confidence: 80,
            found_by: 'Rdf Generator (Passive Detection)',
            interesting_entries: [
              'http://ex.lo/feed/rdf/, <generatoragent rdf:resource="https://wordpress.org/?v=4.0"></generatoragent>'
            ]
          )
        ]
      end

      context 'when :mixed mode' do
        it 'avoids checking existing URL/s from #passive' do
          expect(finder.aggressive(mode: :mixed)).to eql []
        end
      end

      context 'when no mode' do
        it 'checks all the URLs' do
          stub_request(:get, target.url('feed/rdf/'))

          expect(finder.aggressive).to eql []
        end
      end
    end
  end
end
