# encoding: UTF-8

shared_examples 'WpItem::Existable' do
  let(:fixtures_dir) { MODELS_FIXTURES + '/wp_item/existable' }

  describe '#exists?' do
    context 'when the response is supplied' do
      let(:response) { Typhoeus::Response.new }

      it 'does not create a request' do
        expect(Browser).not_to receive(:get)
        allow(subject).to receive(:exists_from_response?).and_return(true)

        expect(subject.exists?({}, response)).to be_truthy
      end
    end

    context 'when the response is not supplied' do
      it 'creates a request' do
        expect(Browser).to receive(:get)
        allow(subject).to receive(:exists_from_response?).and_return(false)

        expect(subject.exists?).to be_falsey
      end
    end
  end

  describe '#exists_from_response?' do
    let(:exists_options) { {} }
    let(:body)           { 'hello world!' }

    after do
      response = Typhoeus::Response.new(@resp_opt)
      expect(subject.send(:exists_from_response?, response, exists_options)).to eq @expected
    end

    context 'when invalid response.code' do
      it 'returns false' do
        @resp_opt = { code: 500 }
        @expected = false
      end
    end

    context 'when the body hash = homepage_hash or error_404_hash' do
      let(:exists_options) { { homepage_hash: Digest::MD5.hexdigest(body) } }

      it 'returns false' do
        @resp_opt = { code: 200, body: body }
        @expected = false
      end
    end

    context 'w/o exclude_content' do
      [200, 401, 403].each do |code|
        it "returns true on #{code}" do
          @resp_opt = { code: code, body: '' }
          @expected = true
        end
      end
    end

    context 'with exclude_content' do
      let(:exists_options) { { exclude_content: %r{world!} } }

      context 'when the body match' do
        it 'returns false' do
          @resp_opt = { code: 200, body: body }
          @expected = false
        end
      end

      context 'when the body does not match' do
        it 'returns true' do
          @resp_opt = { code: 200, body: 'hello dude!' }
          @expected = true
        end
      end
    end

    context 'when it\'s a redirect to the homepage' do
      context 'and the cache generation time is in comment tag' do
        let(:body)             { File.new(fixtures_dir + '/cache_generation.html').read }
        let(:uncommented_body) { body.gsub(/<!--.*?-->/m, '') }
        let(:exists_options)   { { homepage_hash: Digest::MD5.hexdigest(uncommented_body) } }

        it 'returns false' do
          @resp_opt = { code: 200, body: body }
          @expected = false
        end
      end
    end
  end

end
