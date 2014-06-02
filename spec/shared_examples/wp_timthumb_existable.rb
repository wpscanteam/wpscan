# encoding: UTF-8

shared_examples 'WpTimthumb::Existable' do

  describe 'exists_from_response?' do
    after do
      response = Typhoeus::Response.new(@resp_opt)
      expect(subject.send(:exists_from_response?, response)).to eq @expected
    end

    context 'when the status is not a 400' do
      it 'returns false' do
        @resp_opt = { code: 200 }
        @expected = false
      end
    end

    context 'when the status is a 400' do
      let(:opt) { { code: 400 } }

      context 'when the body contains "no image specified"' do
        it 'returns true' do
          @resp_opt = opt.merge(body: 'The following error(s) occured:<br/>No image specified')
          @expected = true
        end
      end

      context 'otherwise' do
        it 'returns false' do
          @resp_opt = opt.merge(body: 'im a fake one, hehe')
          @expected = false
        end
      end
    end
  end

end
