# frozen_string_literal: true

describe WPScan::Finders::Users::AuthorPosts do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://wp.lab/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('users', 'author_posts') }

  describe '#passive' do
    let(:homepage_body) { File.read(fixtures.join('potential_usernames.html')) }

    before do
      expect(target).to receive(:homepage_res).at_least(:once)
                                              .and_return(Typhoeus::Response.new(body: homepage_body))
      expect(target).to receive(:in_scope_uris).and_yield(
        Addressable::URI.parse("#{url}author/admin/"),
        double(text: '')
      ).and_yield(
        Addressable::URI.parse("#{url}?author=2"),
        double(text: 'admin display_name')
      ).and_yield(
        Addressable::URI.parse("#{url}author/editor/"),
        double(text: '')
      ).and_yield(
        Addressable::URI.parse("#{url}?author=3"),
        double(text: 'editor')
      )
    end

    it 'returns Users with expected usernames and confidence' do
      users = finder.passive

      expect(users.size).to eq 4
      expect(users[0]).to be_a WPScan::Model::User
      expect(users[0].username).to eq 'admin'
      expect(users[0].confidence).to eq 100
      expect(users[0].found_by).to match(/Author Posts.*Author Pattern/)

      expect(users[1].username).to eq 'admin display_name'
      expect(users[1].confidence).to eq 30
      expect(users[1].found_by).to match(/Author Posts.*Display Name/)

      expect(users[2].username).to eq 'editor'
      expect(users[2].confidence).to eq 100

      expect(users[3].username).to eq 'editor'
      expect(users[3].confidence).to eq 30
    end
  end

  describe '#potential_usernames' do
    it 'returns the expected usernames' do
      res = Typhoeus::Response.new(body: File.read(fixtures.join('potential_usernames.html')))

      results = finder.potential_usernames(res)

      expect(results).to eql [
        ['admin', 'Author Pattern', 100],
        ['admin display_name', 'Display Name', 30],
        ['editor', 'Author Pattern', 100],
        ['editor', 'Display Name', 30]
      ]
    end

    context 'when a lot of unrelated uris' do
      it 'should not take a while to process the page' do
        body =  Array.new(300) { |i| "<a href='#{url}#{i}.html'>Some Link</a>" }.join("\n")
        body << "<a href='#{url}author/admin/'>Other Link</a>"
        body << "<a href='#{url}?author=2'>user display name</a>"

        time_start = Time.now
        results = finder.potential_usernames(Typhoeus::Response.new(body: body))
        time_end = Time.now

        expect(results).to eql [
          ['admin', 'Author Pattern', 100],
          ['user display name', 'Display Name', 30]
        ]

        expect(time_end - time_start).to be < 1
      end
    end
  end
end
