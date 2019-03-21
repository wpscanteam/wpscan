# frozen_string_literal: true

describe WPScan::Finders::Users::WpJsonApi do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://wp.lab/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('users', 'wp_json_api') }

  describe '#aggressive' do
    before { allow(target).to receive(:sub_dir).and_return(false) }

    context 'when only one page of results' do
      before do
        stub_request(:get, finder.api_url)
          .with(query: { page: 1, per_page: 100 })
          .to_return(body: body, headers: {})
      end

      context 'when not a JSON response' do
        let(:body) { '' }

        its(:aggressive) { should eql([]) }
      end

      context 'when a JSON response' do
        context 'when unauthorised' do
          let(:body) { File.read(fixtures.join('401.json')) }

          its(:aggressive) { should eql([]) }
        end

        context 'when limited exposure (WP >= 4.7.1)' do
          let(:body) { File.read(fixtures.join('4.7.2.json')) }

          it 'returns the expected array of users' do
            users = finder.aggressive

            expect(users.size).to eql 1

            user = users.first

            expect(user.id).to eql 1
            expect(user.username).to eql 'admin'
            expect(user.confidence).to eql 100
            expect(user.interesting_entries).to eql ['http://wp.lab/wp-json/wp/v2/users/?page=1&per_page=100']
          end
        end
      end
    end

    context 'when multiple pages of results' do
      before do
        stub_request(:get, finder.api_url)
          .with(query: { page: 1, per_page: 100 })
          .to_return(body: File.read(fixtures.join('4.7.2.json')), headers: { 'X-WP-TotalPages' => 2 })

        stub_request(:get, finder.api_url)
          .with(query: { page: 2, per_page: 100 })
          .to_return(body: File.read(fixtures.join('4.7.2-2.json')), headers: { 'X-WP-TotalPages' => 2 })
      end

      it 'returns the expected array of users' do
        users = finder.aggressive

        expect(users.size).to eql 2

        user = users.first

        expect(user.id).to eql 1
        expect(user.username).to eql 'admin'
        expect(user.confidence).to eql 100
        expect(user.interesting_entries).to eql ['http://wp.lab/wp-json/wp/v2/users/?page=1&per_page=100']

        user = users.second

        expect(user.id).to eql 20
        expect(user.username).to eql 'user'
        expect(user.confidence).to eql 100
        expect(user.interesting_entries).to eql ['http://wp.lab/wp-json/wp/v2/users/?page=2&per_page=100']
      end
    end
  end
end
