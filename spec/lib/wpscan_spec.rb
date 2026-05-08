# frozen_string_literal: true

describe WPScan do
  it 'has a version number' do
    expect(WPScan::VERSION).not_to be nil
  end

  describe '#app_name' do
    it 'returns the overriden string' do
      expect(WPScan.app_name).to eql 'wpscan'
    end
  end

  describe '#user_cache_dir' do
    context 'when XDG_CACHE_HOME is not set' do
      before do
        stub_const('ENV', ENV.to_hash.tap { |e| e.delete('XDG_CACHE_HOME') })
        allow(Dir).to receive(:home).and_return('/home/user')
      end

      it 'returns the default XDG cache path' do
        expect(WPScan.user_cache_dir.to_s).to eql '/home/user/.cache/wpscan'
      end
    end

    context 'when XDG_CACHE_HOME is set' do
      before { stub_const('ENV', ENV.to_hash.merge('XDG_CACHE_HOME' => '/home/user/cache')) }

      it 'returns the XDG cache path' do
        expect(WPScan.user_cache_dir.to_s).to eql '/home/user/cache/wpscan'
      end
    end
  end

  describe 'status code tracking' do
    before do
      WPScan.reset_status_codes
      # Reset other counters too
      WPScan.total_requests = 0
      WPScan.cached_requests = 0
    end

    describe '.status_codes' do
      it 'returns an empty hash initially' do
        expect(WPScan.status_codes).to be_a(Hash)
        expect(WPScan.status_codes).to be_empty
      end

      it 'defaults to 0 for new status codes' do
        expect(WPScan.status_codes[200]).to eq 0
      end
    end

    describe '.top_status_codes' do
      context 'when no status codes recorded' do
        it 'returns an empty hash' do
          expect(WPScan.top_status_codes).to eq({})
        end
      end

      context 'when status codes are recorded' do
        before do
          WPScan.set_status_code(200, 100)
          WPScan.set_status_code(404, 50)
          WPScan.set_status_code(500, 30)
          WPScan.set_status_code(301, 20)
          WPScan.set_status_code(429, 10)
          WPScan.set_status_code(403, 5)
        end

        it 'returns the top 5 status codes by default' do
          expected = { 200 => 100, 404 => 50, 500 => 30, 301 => 20, 429 => 10 }
          expect(WPScan.top_status_codes).to eq(expected)
        end

        it 'returns the specified number of top status codes' do
          expected = { 200 => 100, 404 => 50, 500 => 30 }
          expect(WPScan.top_status_codes(3)).to eq(expected)
        end
      end
    end

    describe '.concerning_error_codes?' do
      before { WPScan.total_requests = 100 }

      context 'when no requests made' do
        before { WPScan.total_requests = 0 }

        it 'returns false' do
          expect(WPScan.concerning_error_codes?).to be false
        end
      end

      context 'when mostly successful requests' do
        before do
          WPScan.set_status_code(200, 80)
          WPScan.set_status_code(404, 15)
          WPScan.set_status_code(301, 5)
        end

        it 'returns false' do
          expect(WPScan.concerning_error_codes?).to be false
        end
      end

      context 'when many 404 errors (which are expected)' do
        before do
          WPScan.set_status_code(200, 40)
          WPScan.set_status_code(404, 60)
        end

        it 'returns false because 404s are excluded' do
          expect(WPScan.concerning_error_codes?).to be false
        end
      end

      context 'when more than 20% errors (excluding 404)' do
        before do
          WPScan.set_status_code(200, 70)
          WPScan.set_status_code(500, 25)
          WPScan.set_status_code(404, 5)
        end

        it 'returns true' do
          expect(WPScan.concerning_error_codes?).to be true
        end
      end

      context 'when more than 10 rate limit errors' do
        before do
          WPScan.set_status_code(200, 85)
          WPScan.set_status_code(429, 15)
        end

        it 'returns true' do
          expect(WPScan.concerning_error_codes?).to be true
        end
      end

      context 'when more than 10 server errors' do
        before do
          WPScan.set_status_code(200, 85)
          WPScan.set_status_code(500, 8)
          WPScan.set_status_code(502, 4)
        end

        it 'returns true' do
          expect(WPScan.concerning_error_codes?).to be true
        end
      end

      context 'when many failed requests (code 0)' do
        before do
          WPScan.set_status_code(200, 85)
          WPScan.set_status_code(0, 15) # 15 failed requests
        end

        it 'returns true' do
          expect(WPScan.concerning_error_codes?).to be true
        end
      end

      context 'when failed requests are below threshold' do
        before do
          WPScan.set_status_code(200, 92)
          WPScan.set_status_code(0, 8) # Only 8 failed requests
        end

        it 'returns false' do
          expect(WPScan.concerning_error_codes?).to be false
        end
      end

      context 'when more than 20% are failed requests (code 0)' do
        before do
          WPScan.set_status_code(200, 70)
          WPScan.set_status_code(0, 25) # 25% failed requests
          WPScan.set_status_code(404, 5) # Should still be excluded
        end

        it 'returns true' do
          expect(WPScan.concerning_error_codes?).to be true
        end
      end
    end

    describe '.format_status_codes' do
      context 'when codes include 0 (failed requests)' do
        it 'converts code 0 to "failed" label' do
          codes = { 200 => 100, 0 => 20, 404 => 10 }
          formatted = WPScan.format_status_codes(codes)

          expect(formatted).to eq({ '200' => 100, 'failed' => 20, '404' => 10 })
        end
      end

      context 'when codes do not include 0' do
        it 'converts all codes to string labels' do
          codes = { 200 => 100, 404 => 50, 500 => 30 }
          formatted = WPScan.format_status_codes(codes)

          expect(formatted).to eq({ '200' => 100, '404' => 50, '500' => 30 })
        end
      end
    end

    describe '.error_warning_messages' do
      before { WPScan.total_requests = 100 }

      context 'when no requests made' do
        before { WPScan.total_requests = 0 }

        it 'returns empty array' do
          expect(WPScan.error_warning_messages).to eq([])
        end
      end

      context 'when no concerning errors' do
        before do
          WPScan.set_status_code(200, 90)
          WPScan.set_status_code(404, 10)
        end

        it 'returns empty array' do
          expect(WPScan.error_warning_messages).to eq([])
        end
      end

      context 'when single error condition met' do
        before do
          WPScan.set_status_code(200, 85)
          WPScan.set_status_code(429, 15)
        end

        it 'returns array with one warning message' do
          messages = WPScan.error_warning_messages
          expect(messages.count).to eq(1)
          expect(messages.first).to match(/Rate limiting detected/)
        end
      end

      context 'when multiple error conditions met' do
        before do
          WPScan.set_status_code(200, 50)
          WPScan.set_status_code(429, 15)  # Rate limiting
          WPScan.set_status_code(500, 20)  # Server errors
          WPScan.set_status_code(0, 15)    # Failed requests
        end

        it 'returns array with all applicable warning messages' do
          messages = WPScan.error_warning_messages
          expect(messages.count).to eq(3)
          expect(messages).to include(/Too many failed requests/)
          expect(messages).to include(/Rate limiting detected/)
          expect(messages).to include(/Too many server errors/)
        end
      end

      context 'when many 403 forbidden errors' do
        before do
          WPScan.set_status_code(200, 50)
          WPScan.set_status_code(403, 30)  # Many 403 Forbidden
          WPScan.set_status_code(401, 20)  # Some 401 Unauthorized
        end

        it 'returns client error warning' do
          messages = WPScan.error_warning_messages
          expect(messages.count).to eq(1)
          expect(messages.first).to match(/Too many client errors.*access restrictions/)
        end
      end

      context 'when both failed requests and 403 errors (like real scan)' do
        before do
          # Simulating the user's real example
          WPScan.total_requests = 2440
          WPScan.set_status_code(200, 23)
          WPScan.set_status_code(302, 1)
          WPScan.set_status_code(403, 205)  # 403 Forbidden
          WPScan.set_status_code(404, 846)  # 404s (excluded from warnings)
          WPScan.set_status_code(0, 1365)   # Failed requests
        end

        it 'returns warnings for both conditions' do
          messages = WPScan.error_warning_messages
          expect(messages.count).to eq(2)
          expect(messages).to include(/Too many failed requests/)
          expect(messages).to include(/Too many client errors/)
        end
      end

      context 'when high error rate but below specific thresholds' do
        before do
          WPScan.set_status_code(200, 78)
          WPScan.set_status_code(400, 5)   # Client error
          WPScan.set_status_code(403, 5)   # Client error (total client = 10, not > 10)
          WPScan.set_status_code(500, 6)   # Server error (not > 10)
          WPScan.set_status_code(0, 6)     # Failed requests (not > 10)
          # Total errors = 10 + 6 + 6 = 22 out of 100 = 22% > 20%
        end

        it 'returns generic high error rate warning' do
          messages = WPScan.error_warning_messages
          expect(messages.count).to eq(1)
          expect(messages.first).to match(/Too many errors detected/)
        end
      end
    end
  end
end
