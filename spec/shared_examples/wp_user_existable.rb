# encoding: UTF-8

shared_examples 'WpUser::Existable' do
  let(:mod) { WpUser::Existable }
  let(:fixtures_dir) { MODELS_FIXTURES + '/wp_user/existable' }

  describe '::login_from_author_pattern' do
    after do
      mod.login_from_author_pattern(@text).should == @expected
    end

    context 'when no trailing slash' do
      it 'returns the correct login' do
        @text    = '/aurhor/neo'
        @expeced = 'neo'
      end
    end

    context 'when trailing slash' do
      it 'returns the correct login' do
        @text     = '/author/admin/'
        @expected = 'admin'
      end
    end

    context 'when pattern not found' do
      it 'returns nil' do
        @text     = 'im not from this world'
        @expected = nil
      end
    end
  end

  describe '::login_from_body' do
    after { mod.login_from_body(body).should == @expected }

    context 'when the author pattern is in the body' do
      let(:body) { '/author/admin' }

      it 'returns it' do
        mod.stub(:login_from_body).with(body).and_return('admin')
        @expected = 'admin'
      end
    end

    context 'otherwise' do
      let(:body) { '<body class="archive author author-user2 author-1 custom-font-enabled single-author">' }

      it 'gets the login from the body class' do
        @expected = 'user2'
      end
    end
  end

  describe '::display_name_from_body' do
    after { mod.display_name_from_body(@body).should == @expected }

    context 'when pattern not found' do
      it 'returns nil' do
        @body     = 'im not there'
        @expected = nil
      end
    end

    context 'when the title tag is empty' do
      it 'returns nil' do
        @body     = '<title></title>'
        @expected = nil
      end
    end

    context 'when the body is an ASCII-8BIT' do
      it 'return the correct display_name' do
        @body = '<title>its me  |  wordpress</title>'.encode('ASCII-8BIT')
        @expected = 'its me'
      end
    end

    context 'when pattern is found' do
      context 'when unencoded extra chars' do
        it 'returns the display_name w/o extra chars' do
          @body = '<title>admin display | Wordpress-3.5.1</title>'
          @expected = 'admin display'
        end
      end

      context 'when encoded extra chars' do
        it 'returns the display_name w/o extra chars' do
          @body = '<title>user user &#124; Wordpress-3.5.1</title>'
          @expected = 'user user'
        end

        context 'when custom extra chars' do
          it 'detects them' do
            @body     = '<title>admin &laquo; Wiener</title>'
            @expected = 'admin'
          end
        end
      end

      it 'decodes entities' do
        @body     = '<title>user &amp; nickname &#124; Wordpress-3.5.1</title>'
        @expected = 'user & nickname'
      end
    end
  end

  describe '#load_from_response' do
    after do
      response = Typhoeus::Response.new(@resp_opt || resp_opt)
      subject.send(:load_from_response, response)

      subject.login.should == @login
      subject.display_name.should == @display_name
    end

    context 'with a 301' do
      let(:location) { 'http://lamp/wordpress-3.5.1/author/admin/' }
      let(:resp_opt) { { code: 301, headers: { 'Location' => location } } }

      it 'loads the correct values' do
        stub_request(:get, location).to_return(body: '<title>admin name | wp</title>')

        @login        = 'admin'
        @display_name = 'admin name'
      end
    end

    context 'with a 200' do
      let(:resp_opt) { { code: 200, body: File.new(fixtures_dir + '/admin.html').read } }

      it 'loads the correct values' do
        @login        = 'admin'
        @display_name = 'admin d-name'
      end
    end

    context 'otherwise' do
      it 'does not do anything' do
        @resp_opt     = { code: 404 }
        @login        = nil
        @display_name = nil
      end
    end
  end

  describe '#exists_from_response?' do
    after do
      response = Typhoeus::Response.new(@resp_opt || resp_opt)
      subject.exists_from_response?(response).should == @expected
    end

    context 'login not found' do
      it 'returns false' do
        @resp_opt = { code: 404 }
        @expected = false
      end
    end

    context 'login found' do
      it 'returns true' do
        @resp_opt = { code: 200, body: File.new(fixtures_dir + '/admin.html').read }
        @expected = true
      end
    end
  end

end
