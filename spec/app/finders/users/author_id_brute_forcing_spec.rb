# frozen_string_literal: true

describe WPScan::Finders::Users::AuthorIdBruteForcing do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://wp.lab/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('users', 'author_id_brute_forcing') }

  describe '#aggressive' do
    let(:opts) { { range: (1..3) } }

    before do
      stub_request(:get, url).to_return(status: 200, body: '')
      stub_request(:head, url).to_return(status: 200)
      (1..3).each do |id|
        stub_request(:head, "#{url}?author=#{id}").to_return(status: 404)
        stub_request(:get, "#{url}?author=#{id}").to_return(status: 404)
      end
    end

    context 'when no users found' do
      it 'returns empty array' do
        expect(finder.aggressive(opts)).to eql []
      end
    end

    context 'when users found via author URL redirect' do
      let(:body) { '<html><body><a href="/author/admin/">admin</a></body></html>' }

      before do
        expect(target).to receive(:homepage_or_404?).and_return(false)
        expect(target).to receive(:in_scope_uris).and_yield(Addressable::URI.parse("#{url}author/admin/"))
        stub_request(:head, "#{url}?author=1").to_return(status: 200)
        stub_request(:get, "#{url}?author=1").to_return(status: 200, body: body)
      end

      it 'returns User with username from URL' do
        users = finder.aggressive(opts)

        expect(users.size).to eq 1
        expect(users.first).to be_a WPScan::Model::User
        expect(users.first.username).to eq 'admin'
        expect(users.first.id).to eq 1
        expect(users.first.confidence).to eq 100
        expect(users.first.found_by).to match(/Author Id Brute Forcing/)
      end
    end

    context 'when users found via body class' do
      let(:body) { '<body class="archive author author-testuser logged-in">' }

      before do
        expect(target).to receive(:homepage_or_404?).and_return(false)
        stub_request(:head, "#{url}?author=2")
          .to_return(status: 200)
        stub_request(:get, "#{url}?author=2")
          .to_return(status: 200, body: body)
      end

      it 'returns User with username from body' do
        users = finder.aggressive(opts)

        expect(users.size).to eq 1
        expect(users.first.username).to eq 'testuser'
        expect(users.first.id).to eq 2
      end
    end

    context 'when users found via display name' do
      let(:body) do
        <<-HTML
          <html>
            <body class="archive">
              <h1 class="page-title">Author: <span class="vcard">admin display_name</span></h1>
            </body>
          </html>
        HTML
      end

      before do
        expect(target).to receive(:homepage_or_404?).and_return(false)
        expect(target).to receive(:in_scope_uris).and_return([])
        stub_request(:head, "#{url}?author=3")
          .to_return(status: 200)
        stub_request(:get, "#{url}?author=3")
          .to_return(status: 200, body: body)
      end

      it 'returns User with display name and lower confidence' do
        users = finder.aggressive(opts)

        expect(users.size).to eq 1
        expect(users.first.username).to eq 'admin display_name'
        expect(users.first.id).to eq 3
        expect(users.first.confidence).to eq 50
        expect(users.first.found_by).to match(/Display Name/)
      end
    end

    context 'when multiple users found' do
      let(:body1) { '<html><body><a href="/author/user1/">user1</a></body></html>' }
      let(:body2) { '<html><body><a href="/author/user2/">user2</a></body></html>' }

      before do
        expect(target).to receive(:homepage_or_404?).at_least(:once).and_return(false)
        expect(target).to receive(:in_scope_uris).and_yield(Addressable::URI.parse("#{url}author/user1/"))
        expect(target).to receive(:in_scope_uris).and_yield(Addressable::URI.parse("#{url}author/user2/"))

        stub_request(:head, "#{url}?author=1").to_return(status: 200)
        stub_request(:get, "#{url}?author=1").to_return(status: 200, body: body1)

        stub_request(:head, "#{url}?author=2").to_return(status: 200)
        stub_request(:get, "#{url}?author=2").to_return(status: 200, body: body2)
      end

      it 'returns all found users' do
        users = finder.aggressive(opts)

        expect(users.size).to eq 2
        expect(users.map(&:username)).to contain_exactly('user1', 'user2')
        expect(users.map(&:id)).to contain_exactly(1, 2)
      end
    end
  end

  describe '#target_urls' do
    it 'returns the correct URLs' do
      expect(finder.target_urls(range: (1..2))).to eql(
        "#{url}?author=1" => 1,
        "#{url}?author=2" => 2
      )
    end
  end

  describe '#username_from_response' do
    [
      '4.1.1', '4.1.1-permalink',
      '3.0', '3.0-permalink',
      '2.9.2', '2.9.2-permalink'
    ].each do |file|
      it "returns 'admin' from #{file}.html" do
        body = File.read(fixtures.join("#{file}.html"))
        res = Typhoeus::Response.new(body: body)

        expect(finder.username_from_response(res)).to eql 'admin'
      end
    end

    context 'when a lot of unrelated links' do
      it 'should not take a while to process the page' do
        body = Array.new(300) { |i| "<a href='#{url}#{i}.html'>Some Link</a>" }.join("\n")
        body << '<a href="https://wp.lab/author/test/">Link</a>'

        time_start = Time.now
        expect(finder.username_from_response(Typhoeus::Response.new(body: body))).to eql 'test'
        time_end = Time.now

        expect(time_end - time_start).to be < 1
      end
    end
  end

  describe '#display_name_from_body' do
    context 'when display name' do
      [
        '4.1.1', '4.1.1-permalink',
        '3.0', '3.0-permalink',
        '2.9.2', '2.9.2-permalink'
      ].each do |file|
        it "returns 'admin display_name' from #{file}.html" do
          body = File.read(fixtures.join("#{file}.html"))

          expect(finder.display_name_from_body(body)).to eql 'admin display_name'
        end
      end
    end

    context 'when no display_name' do
      %w[4.9-span-tag 4.1.1 3.0 2.9.2].each do |file|
        it "returns nil for #{file}-empty.html" do
          body = File.read(fixtures.join("#{file}-empty.html"))

          expect(finder.display_name_from_body(body)).to eql nil
        end
      end
    end
  end
end
