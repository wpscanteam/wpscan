# encoding: UTF-8

shared_examples 'WpItem::Infos' do

  # 2 expected urls have to be set in the described class (or subject)
  # e.g :
  #  let(:changelog_url) { }
  #  let(:error_log_url) { }

  describe '#readme_url' do
    after { subject.readme_url.should === @expected }

    it 'returns nil' do
      stub_request(:get, /.*/).to_return(status: 404)
      @expected = nil
    end

    context 'when the file exists' do
      %w{readme.txt README.txt}.each do |readme|
        it 'returns the correct url' do
          url       = uri.merge(readme).to_s
          @expected = url

          stub_request(:get, %r{^(?!#{url})}).to_return(status: 404)
          stub_request(:get, url).to_return(status: 200)
        end
      end
    end
  end

  describe '#has_readme?' do
    after do
      subject.stub(readme_url: @stub)
      subject.has_readme?.should === @expected
    end

    context 'when readme_url is nil'
    it 'returns false' do
      @stub     = nil
      @expected = false
    end

    context 'when readme_url is not nil'
    it 'returns true' do
      @stub     = uri.merge('readme.txt').to_s
      @expected = true
    end
  end

  describe '#changelog_url' do
    it 'returns the correct url' do
      subject.changelog_url.should == changelog_url
    end
  end

  describe '#has_changelog?' do
    after :each do
      stub_request(:get, subject.changelog_url).to_return(status: @status)
      subject.has_changelog?.should === @expected
    end

    it 'returns true on a 200' do
      @status   = 200
      @expected = true
    end

    it 'returns false otherwise' do
      @status   = 404
      @expected = false
    end
  end

  describe '#has_directory_listing?' do
    after do
      stub_request(:get, subject.uri.to_s).to_return(@stub_return)
      subject.has_directory_listing?.should === @expected
    end

    context 'when the body contains <title>Index of' do
      it 'returns true' do
        @stub_return = { status: 200, body: '<title>Index of asdf</title>' }
        @expected    = true
      end
    end

    it 'returns false otherwise' do
      @stub_return = { status: 200, body: '<title>My Wordpress Site</title>' }
      @expected    = false
    end

    it 'returns false on a 404' do
      @stub_return = { status: 404 }
      @expected    = false
    end
  end

  describe '#error_log_url' do
    it 'returns the correct url' do
      subject.error_log_url.should == error_log_url
    end
  end

  describe '#has_error_log?' do
    after do
      stub_request(:get, subject.error_log_url).to_return(@stub_return)
      subject.has_error_log?.should === @expected
    end

    it 'returns true if the pattern is detected' do
      @stub_return = { status: 200, body: File.new( MODELS_FIXTURES + '/wp_item/error_log') }
      @expected    = true
    end

    it 'returns false otherwise' do
      @stub_return = { status: 200, body: 'yolo' }
      @expected    = false
    end

    it 'returns false on a 404' do
      @stub_return = { status: 404 }
      @expected    = false
    end
  end

end
