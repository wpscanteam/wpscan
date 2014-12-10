# encoding: UTF-8

shared_examples 'WpTheme::Versionable' do
  let(:fixtures_dir) { MODELS_FIXTURES + '/wp_theme/versionable/' }

  describe '#version' do
    after do
      if @file
        body = File.new(fixtures_dir + @file)
        stub_request(:get, subject.style_url).to_return(status: 200, body: body)
      end

      expect(subject.version).to eq @expected
    end

    context 'the version is already set' do
      it 'returns it' do
        subject.version = '2.1'
        @expected = '2.1'
      end
    end

    context 'when the version is not found' do
      it 'returns nil' do
        @file     = 'twentyeleven-unknow.css'
        @expected = nil
      end
    end

    context 'when the stylesheet is inline' do
      it 'returns the correct version' do
        @file     = 'bueno-1.5.1.css'
        @expected = '1.5.1'
      end
    end

    it 'returns the correct version' do
      @file = 'twentyeleven-1.3.css'
      @expected = '1.3'
    end

    it 'returns the correct version' do
      @file = 'firefart.net.css'
      @expected = '1.0.0'
    end
  end

end
