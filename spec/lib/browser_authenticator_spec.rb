# frozen_string_literal: true

describe WPScan::BrowserAuthenticator do
  # Lightweight stand-in for a Ferrum::Cookies::Cookie, which only needs
  # to expose #name and #value for serialize_cookies.
  Cookie = Struct.new(:name, :value)

  describe '.serialize_cookies' do
    it 'joins cookies into a single Cookie-header string' do
      cookies = {
        'session_id' => Cookie.new('session_id', 'abc123'),
        'auth_token' => Cookie.new('auth_token', 'xyz789')
      }

      expect(described_class.serialize_cookies(cookies)).to eq('session_id=abc123; auth_token=xyz789')
    end

    it 'returns an empty string when given an empty hash' do
      expect(described_class.serialize_cookies({})).to eq('')
    end

    it 'coerces non-string values via #to_s' do
      cookies = { 'n' => Cookie.new('n', 42) }

      expect(described_class.serialize_cookies(cookies)).to eq('n=42')
    end

    [';', ',', ' ', "\t", "\r", "\n"].each do |bad_char|
      it "raises SAMLAuthenticationFailed when a cookie name contains #{bad_char.inspect}" do
        cookies = { 'bad' => Cookie.new("ev#{bad_char}il", 'v') }

        expect { described_class.serialize_cookies(cookies) }
          .to raise_error(WPScan::Error::SAMLAuthenticationFailed)
      end

      it "raises SAMLAuthenticationFailed when a cookie value contains #{bad_char.inspect}" do
        cookies = { 'k' => Cookie.new('k', "ev#{bad_char}il") }

        expect { described_class.serialize_cookies(cookies) }
          .to raise_error(WPScan::Error::SAMLAuthenticationFailed)
      end
    end
  end

  describe '.authenticate' do
    let(:login_url) { 'https://idp.example.com/sso?SAMLRequest=abc' }
    let(:browser)   { instance_double(Ferrum::Browser, goto: nil, current_url: login_url, quit: nil, process: true) }
    let(:cookies)   { instance_double(Ferrum::Cookies, all: cookie_jar) }
    let(:cookie_jar) { { 'sid' => Cookie.new('sid', 'abc') } }

    before do
      allow($stdin).to receive(:tty?).and_return(true)
      allow(Ferrum::Browser).to receive(:new).and_return(browser)
      allow(browser).to receive(:cookies).and_return(cookies)
      allow(described_class).to receive(:gets).and_return("\n")
      allow(described_class).to receive(:puts)
    end

    context 'when stdin is not a TTY' do
      before { allow($stdin).to receive(:tty?).and_return(false) }

      it 'raises BrowserFailed without launching a browser' do
        expect(Ferrum::Browser).not_to receive(:new)

        expect { described_class.authenticate(login_url) }
          .to raise_error(WPScan::Error::BrowserFailed)
      end
    end

    context 'when the browser returns cookies' do
      it 'returns the serialized cookie string and quits the browser' do
        expect(browser).to receive(:goto).with(login_url)
        expect(browser).to receive(:quit)

        expect(described_class.authenticate(login_url)).to eq('sid=abc')
      end
    end

    context 'when the browser raises Ferrum::BrowserError' do
      before { allow(browser).to receive(:goto).and_raise(Ferrum::BrowserError.new('msg' => 'boom')) }

      it 'raises BrowserFailed and still quits the browser' do
        expect(browser).to receive(:quit)

        expect { described_class.authenticate(login_url) }
          .to raise_error(WPScan::Error::BrowserFailed)
      end
    end

    context 'when the browser raises Ferrum::DeadBrowserError' do
      before { allow(browser).to receive(:current_url).and_raise(Ferrum::DeadBrowserError) }

      it 'raises BrowserFailed' do
        expect { described_class.authenticate(login_url) }
          .to raise_error(WPScan::Error::BrowserFailed)
      end
    end

    context 'when the browser returns no cookies' do
      let(:cookie_jar) { {} }

      it 'raises SAMLAuthenticationFailed' do
        expect { described_class.authenticate(login_url) }
          .to raise_error(WPScan::Error::SAMLAuthenticationFailed)
      end
    end

    context 'when the browser returns nil cookies' do
      let(:cookie_jar) { nil }

      it 'raises SAMLAuthenticationFailed' do
        expect { described_class.authenticate(login_url) }
          .to raise_error(WPScan::Error::SAMLAuthenticationFailed)
      end
    end
  end
end
