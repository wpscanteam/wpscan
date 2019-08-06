# frozen_string_literal: true

describe WPScan::Finders::Passwords::WpLogin do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://ex.lo/' }

  describe '#valid_credentials?' do
    context 'when a non 302' do
      it 'returns false' do
        expect(finder.valid_credentials?(Typhoeus::Response.new(code: 200, headers: {}))).to be_falsey
      end
    end

    context 'when a 302' do
      let(:response) { Typhoeus::Response.new(code: 302, headers: headers) }

      context 'when no cookies set' do
        let(:headers) { {} }

        it 'returns false' do
          expect(finder.valid_credentials?(response)).to be_falsey
        end
      end

      context 'when no logged_in cookie set' do
        context 'when only one cookie set' do
          let(:headers) { 'Set-Cookie: wordpress_test_cookie=WP+Cookie+check; path=/' }

          it 'returns false' do
            expect(finder.valid_credentials?(response)).to be_falsey
          end
        end

        context 'when multiple cookies set' do
          let(:headers) do
            "Set-Cookie: wordpress_test_cookie=WP+Cookie+check; path=/\r\n" \
            'Set-Cookie: something=value; path=/'
          end

          it 'returns false' do
            expect(finder.valid_credentials?(response)).to be_falsey
          end
        end
      end

      context 'when logged_in cookie set' do
        let(:headers) do
          "Set-Cookie: wordpress_test_cookie=WP+Cookie+check; path=/\r\r" \
          "Set-Cookie: wordpress_xxx=yyy; path=/wp-content/plugins; httponly\r\n" \
          "Set-Cookie: wordpress_xxx=yyy; path=/wp-admin; httponly\r\n" \
          'Set-Cookie: wordpress_logged_in_xxx=yyy; path=/; httponly'
        end

        it 'returns false' do
          expect(finder.valid_credentials?(response)).to eql true
        end
      end
    end
  end
end
