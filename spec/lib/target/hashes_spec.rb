# frozen_string_literal: true

describe WPScan::Target do
  subject(:target) { described_class.new(url) }
  let(:url)        { 'http://e.org' }

  before { stub_request(:get, /e\.org/) }

  def md5sum(body)
    Digest::MD5.hexdigest(body)
  end

  describe '#page_hash' do
    after { expect(described_class.page_hash(page)).to eql @expected }

    context 'when the page is an url' do
      let(:page) { 'http://e.org/somepage.php' }

      it 'returns the MD5 hash of the page' do
        body = 'Hello World !'

        stub_request(:get, page).to_return(body: body)

        @expected = md5sum(body)
      end
    end

    context 'when the page is a Typhoeus::Response' do
      let(:page) { Typhoeus::Response.new(body: 'Hello Example!') }

      it 'returns the correct hash' do
        @expected = md5sum('Hello Example!')
      end
    end

    context 'when there are comments' do
      let(:page) do
        body = "yolo\n\n<!--I should <script>no longer be</script> there -->\nworld!"
        Typhoeus::Response.new(body: body)
      end

      it 'removes them' do
        @expected = md5sum("yolo\n\n\nworld!")
      end
    end

    context 'when there are script tags' do
      let(:page) do
        body = "aa<script>var t = 'test';</script>bbb"

        Typhoeus::Response.new(body: body)
      end

      it 'removes them' do
        @expected = md5sum('aabbb')
      end
    end
  end

  describe '#homepage_hash' do
    it 'returns the MD5 hash of the homepage' do
      body = 'Hello World'

      stub_request(:get, target.url).to_return(body: body)

      expect(target.homepage_hash).to eql md5sum(body)
    end
  end

  describe '#error_404_hash' do
    it 'returns the md5sum of the 404 page' do
      stub_request(:any, ERROR_404_URL_PATTERN).to_return(status: 404, body: '404 page !')

      expect(target.error_404_hash).to eql md5sum('404 page !')
    end
  end

  describe '#homepage_or_404?' do
    let(:page_url) { target.url('page') }

    before do
      expect(target).to receive(:homepage_hash).and_return(md5sum('Home'))
      expect(target).to receive(:error_404_hash).and_return(md5sum('Custom 404'))

      stub_request(:get, page_url).to_return(body: body)
    end

    context 'when hashes do not match' do
      let(:body) { 'Page!' }

      it 'returns false' do
        expect(target.homepage_or_404?(page_url)).to eql false
      end
    end

    context 'when hashes match' do
      let(:body) { 'Custom 404' }

      it 'returns true' do
        expect(target.homepage_or_404?(page_url)).to eql true
      end
    end
  end
end
