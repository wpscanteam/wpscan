# frozen_string_literal: true

describe WPScan::Finders::Users::AuthorSitemap do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://wp.lab/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('users', 'author_sitemap') }

  describe '#aggressive' do
    before do
      allow(target).to receive(:sub_dir).and_return(false)

      stub_request(:get, finder.sitemap_url).to_return(body: body)
    end

    context 'when not an XML response' do
      let(:body) { '' }

      its(:aggressive) { should eql([]) }
    end

    context 'when an XML response' do
      context 'when no usernames disclosed' do
        let(:body) { File.read(fixtures.join('no_usernames.xml')) }

        its(:aggressive) { should eql([]) }
      end

      context 'when usernames disclosed' do
        let(:body) { File.read(fixtures.join('usernames.xml')) }

        it 'returns the expected array of users' do
          users = finder.aggressive

          expect(users.size).to eql 2

          expect(users.first.username).to eql 'admin'
          expect(users.first.confidence).to eql 100
          expect(users.first.interesting_entries).to eql ['http://wp.lab/wp-sitemap-users-1.xml']

          expect(users.last.username).to eql 'author'
          expect(users.last.confidence).to eql 100
          expect(users.last.interesting_entries).to eql ['http://wp.lab/wp-sitemap-users-1.xml']
        end
      end
    end
  end
end
