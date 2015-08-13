# encoding: UTF-8

shared_examples 'WpUser::Existable' do
  let(:mod) { WpUser::Existable }
  let(:fixtures_dir) { File.join(MODELS_FIXTURES, 'wp_user', 'existable') }

  describe '::login_from_author_pattern' do
    after do
      expect(mod.login_from_author_pattern(@text)).to eq @expected
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

    context 'when no author given' do
      it 'returns nil' do
        @text     = '<a href="http://wp.lab/author/" class="btn btn-default">See Posts</a>'
        @expected = nil
      end
    end
  end

  describe '::login_from_body' do
    after { expect(mod.login_from_body(body)).to eq @expected }

    context 'when the author pattern is in the body' do
      let(:body) { '/author/admin' }

      it 'returns it' do
        allow(mod).to receive(:login_from_body).with(body).and_return('admin')
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
    after { expect(mod.display_name_from_body(@body)).to eq @expected }

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

      expect(subject.login).to eq @login
      expect(subject.display_name).to eq @display_name
    end

    context 'with a 301' do
      let(:location) { 'http://lamp/wordpress-3.5.1/author/admin/' }
      let(:resp_opt) { { code: 301, headers: { 'Location' => location } } }

      it 'loads the correct values' do
        stub_request(:get, location).to_return(body: '<title>admin name | wp</title>')

        @login        = 'admin'
        @display_name = 'admin name'
      end

      context 'when the location is nil' do
        let(:location) { nil }

        it 'returns nil' do
          @login        = nil
          @display_name = nil
        end
      end

      context 'when the location is empty' do
        let(:location) { '' }

        it 'returns nil' do
          @login        = nil
          @display_name = nil
        end
      end
    end

    context 'with a 200' do
      let(:resp_opt) { { code: 200, body: File.read(File.join(fixtures_dir, 'admin.html')) } }

      it 'loads the correct values' do
        @login        = 'admin'
        @display_name = 'admin d-name'
      end
    end

    context 'when chinese chars' do
      let(:resp_opt) { { code: 200, body: File.read(File.join(fixtures_dir, 'chinese_chars.html')) } }

      it 'loads the correct values' do
        @login = '一路疯下去'
        @display_name = nil
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
      expect(subject.exists_from_response?(response)).to eq @expected
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
