# frozen_string_literal: true

shared_examples 'App::Finders::WpItems::UrlsInPage' do
  before do
    allow(finder.target).to receive(:content_dir).and_return('wp-content')

    stub_request(:get, page_url).to_return(body: defined?(body) ? body : File.read(fixtures.join(fixture)))
  end

  describe '#items_from_links' do
    context 'when none found' do
      let(:fixture) { 'none.html' }

      it 'returns an empty array' do
        expect(finder.items_from_links(type)).to eql([])
      end
    end

    context 'when found' do
      let(:fixture) { 'found.html' }

      it 'returns the expected array' do
        expect(finder.items_from_links(type, uniq: uniq_links)).to eql expected_from_links
      end
    end

    context 'when a lof of unrelated links' do
      let(:body) do
        Array.new(250) { |i| "<a href='#{url}#{i}.html'>Link</a><img src='#{url}img-#{i}.gif'/>" }.join("\n")
      end

      it 'should not take a while to process the page' do
        time_start = Time.now
        expect(finder.items_from_links(type)).to eql []
        time_end = Time.now

        expect(time_end - time_start).to be < 1
      end
    end
  end

  describe '#items_from_codes' do
    context 'when none found' do
      let(:fixture) { 'none.html' }

      it 'returns an empty array' do
        expect(finder.items_from_codes(type)).to eql([])
      end
    end

    context 'when found' do
      let(:fixture) { 'found.html' }

      it 'returns the expected array' do
        expect(finder.items_from_codes(type, uniq: uniq_codes)).to eql expected_from_codes
      end
    end
  end
end
