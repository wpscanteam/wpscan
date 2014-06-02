# encoding: UTF-8

shared_examples 'WpItem::Findable#Found_From=' do

  describe '#found_from=' do
    after do
      subject.found_from = @method
      expect(subject.found_from).to eq @expected
    end
    context 'when the pattern is not found' do
      it 'returns nil' do
        @method   = 'I_do_not_match'
        @expected = nil
      end
    end

    it 'replaces _ by space' do
      @method   = 'find_from_some_detection_method'
      @expected = 'some detection method'
    end
  end

end
