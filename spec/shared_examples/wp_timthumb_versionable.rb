# encoding: UTF-8

shared_examples 'WpTimthumb::Versionable' do

  describe '#version' do
    after do
      stub_request(:get, subject.url).to_return(status: 200, body: @body)

      expect(subject.version).to be === @expected
    end

    context 'when a version is already set' do
      it 'returns it' do
        subject.version = '2.3.1'
        @expected       = '2.3.1'
      end
    end

    context 'when the body match' do
      it 'returns the version' do
        @body     = 'Query String :<br />TimThumb version : 2.8.10</pre>'
        @expected = '2.8.10'
      end
    end

    context 'otherwise' do
      it 'returns nil' do
        @body     = 'not in here'
        @expected = nil
      end
    end
  end

  describe '#to_s' do
    after { expect(subject.to_s).to eq @expected }

    context 'when there is a version' do
      it 'returns it with the url' do
        subject.version = '1.3'
        @expected = uri.merge(options[:path]).to_s + ' v1.3'
      end
    end

    context 'when there is not a version' do
      it 'returns only the url' do
        allow(subject).to receive(:version).and_return(nil)
        @expected = uri.merge(options[:path]).to_s
      end
    end
  end

end
