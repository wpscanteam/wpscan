# encoding: UTF-8

shared_examples 'WpItem::Existable' do

  describe '#exists?' do
    context 'when the response is supplied' do
      let(:response) { Typhoeus::Response.new }

      it 'does not create a request' do
        Browser.instance.should_not_receive(:get)
        subject.stub(:exists_from_response?).and_return(true)

        subject.exists?({}, response).should be_true
      end
    end

    context 'when the response is not supplied' do
      it 'creates a request' do
        Browser.instance.should_receive(:get)
        subject.stub(:exists_from_response?).and_return(false)

        subject.exists?.should be_false
      end
    end
  end

  describe '#exists_from_response?' do
    let(:exists_options) { {} }
    let(:body)           { 'hello world!' }

    after do
      response = Typhoeus::Response.new(@resp_opt)
      subject.send(:exists_from_response?, response, exists_options).should == @expected
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
      [200, 301, 302, 401, 403].each do |code|
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
  end

end
