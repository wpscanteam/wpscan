# encoding: UTF-8

shared_examples 'WpItem::Findable#Found_From=' do

  describe '#found_from=' do
    after do
      subject.found_from = @method
      expect(subject.found_from).to eq @expected
    end

    it 'replaces _ by space' do
      @method   = 'find_from_some_detection_method'
      @expected = 'some detection method'
    end
  end

end
