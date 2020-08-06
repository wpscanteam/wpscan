# frozen_string_literal: true

describe WPScan::Finders::Users::AuthorIdBruteForcing do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://wp.lab/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('users', 'author_id_brute_forcing') }

  describe '#aggressive' do
    xit
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
