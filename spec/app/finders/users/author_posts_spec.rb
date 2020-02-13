# frozen_string_literal: true

describe WPScan::Finders::Users::AuthorPosts do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://wp.lab/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('users', 'author_posts') }

  describe '#passive' do
    xit
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
