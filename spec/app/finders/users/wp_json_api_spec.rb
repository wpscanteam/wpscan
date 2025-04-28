# frozen_string_literal: true

describe WPScan::Finders::Users::WpJsonApi do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://wp.lab/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('users', 'wp_json_api') }

  describe '#aggressive' do
    before do
      allow(target).to receive(:sub_dir).and_return(false)
      allow(finder).to receive(:api_url).and_return(target.url('wp-json/wp/v2/users/'))
    end

    context 'when only one page of results' do
      before do
        stub_request(:get, finder.api_url)
          .with(query: { page: 1, per_page: 100 })
          .to_return(body: body, headers: {})
      end

      context 'when not a JSON response' do
        context 'when empty' do
          let(:body) { '' }

          its(:aggressive) { should eql([]) }
        end

        context 'when a string' do
          let(:body) { '404' }

          its(:aggressive) { should eql([]) }
        end
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

  describe '#api_url' do
    let(:fixtures) { super().join('api_url') }

    before { allow(target).to receive(:sub_dir).and_return(false) }

    context 'when url in the homepage' do
      {
        in_scope: 'https://wp.lab/wp-json/wp/v2/users/',
        out_of_scope: 'http://wp.lab/wp-json/wp/v2/users/'
      }.each do |fixture, expected|
        it "returns #{expected} for #{fixture}.html" do
          stub_request(:get, target.url).to_return(body: File.read(fixtures.join("#{fixture}.html")))

          expect(finder.api_url).to eql expected
        end
      end

      context 'when subdir' do
        before { allow(target).to receive(:sub_dir).and_return('cms') }

        {
          in_scope_subdir: 'https://wp.lab/cms/wp-json/wp/v2/users/',
          in_scope_subdir_ignored: 'https://wp.lab/wp-json/wp/v2/users/'
        }.each do |fixture, expected|
          it "returns #{expected} for #{fixture}.html" do
            stub_request(:get, target.url).to_return(body: File.read(fixtures.join("#{fixture}.html")))

            expect(finder.api_url).to eql expected
          end
        end
      end
    end

    context 'when not in the homepage' do
      before { stub_request(:get, target.url) }

      its(:api_url) { should eql target.url('wp-json/wp/v2/users/') }
    end

    context 'when api_url already found' do
      before { allow(target).to receive(:sub_dir).and_return(false) }

      it 'does not check the homepage again' do
        url = target.url('wp-json/wp/v2/users/')

        finder.instance_variable_set(:@api_url, url)

        expect(finder.api_url).to eql url
      end
    end
  end
end
