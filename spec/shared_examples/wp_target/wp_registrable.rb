# encoding: UTF-8

shared_examples 'WpTarget::WpRegistrable' do

  let(:signup_url) { wp_target.uri.merge('wp-signup.php').to_s }

  describe '#registration_url' do
    after { wp_target.registration_url.should === @expected }

    context 'when multisite' do
      it 'returns the signup url' do
        wp_target.stub(:multisite?).and_return(true)

        @expected = signup_url
      end
    end

    context 'when not multisite' do
      it 'returns the login url with ?action=register' do
        wp_target.stub(:multisite?).and_return(false)

        @expected = login_url + '?action=register'
      end
    end
  end

  describe '#registration_enabled?' do
    after do
      wp_target.stub(:multisite?).and_return(multisite)
      stub_request(:get, wp_target.registration_url).to_return(@stub)

      wp_target.registration_enabled?.should === @expected
    end

    context 'when multisite' do
      let(:multisite) { true }
      it 'returns false (multisite)' do
        @stub     = { status: 302, headers: { 'Location' => 'wp-login.php?registration=disabled' } }
        @expected = false
      end

      it 'returns true (multisite)' do
        @stub     = { status: 200, body: %{<form id="setupform" method="post" action="wp-signup.php">} }
        @expected = true
      end
    end

    context 'when not multisite' do
      let(:multisite) { false }

      it 'returns false (not multisite)' do
        @stub     = { status: 302, headers: { 'Location' => 'wp-login.php?registration=disabled' } }
        @expected = false
      end

      it 'returns true (not multisite)' do
        @stub     = { status: 200, body: %{<form name="registerform" id="registerform" action="wp-login.php"} }
        @expected = true
      end

      it 'returns false' do
        @stub     = { status: 500 }
        @expected = false
      end
    end
  end

  describe '#multisite?' do
    after do
      stub_request(:get, signup_url).to_return(@stub)

      wp_target.multisite?.should === @expected
    end

    it 'returns false' do
      @stub     = { status: 302, headers: { 'Location' => 'wp-login.php?action=register' } }
      @expected = false
    end

    it 'returns true' do
      @stub     = { status: 302, headers: { 'Location' => 'http://example.localhost/wp-signup.php' } }
      @expected = true
    end

    it 'returns true' do
      @stub     = { status: 200 }
      @expected = true
    end

    it 'returns false' do
      @stub     = { status: 500 }
      @expected = false
    end
  end

end
