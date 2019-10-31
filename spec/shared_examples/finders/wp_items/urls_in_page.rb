# frozen_string_literal: true

shared_examples 'App::Finders::WpItems::UrlsInPage' do
  before do
    stub_request(:get, page_url).to_return(body: File.read(fixtures.join(file)))
  end

  describe '#items_from_links' do
    context 'when none found' do
      let(:file) { 'none.html' }

      it 'returns an empty array' do
        expect(finder.items_from_links(type)).to eql([])
      end
    end

    context 'when found' do
      let(:file) { 'found.html' }

      it 'returns the expected array' do
        expect(finder.target).to receive(:content_dir).at_least(1).and_return('wp-content')

        expect(finder.items_from_links(type, uniq_links)).to eql expected_from_links
      end
    end
  end

  describe '#items_from_codes' do
    before { expect(finder.target).to receive(:content_dir).at_least(1).and_return('wp-content') }

    context 'when none found' do
      let(:file) { 'none.html' }

      it 'returns an empty array' do
        expect(finder.items_from_codes(type)).to eql([])
      end
    end

    context 'when found' do
      let(:file) { 'found.html' }

      it 'returns the expected array' do
        expect(finder.items_from_codes(type, uniq_codes)).to eql expected_from_codes
      end
    end
  end
end
