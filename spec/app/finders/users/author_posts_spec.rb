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

      expect(results).to eql([
                               ['admin', 'Author Pattern', 100],
                               ['admin display_name', 'Display Name', 30],
                               ['editor', 'Author Pattern', 100],
                               ['editor', 'Display Name', 30]
                             ])
    end
  end
end
