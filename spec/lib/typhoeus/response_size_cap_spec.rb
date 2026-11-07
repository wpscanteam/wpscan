# frozen_string_literal: true

# WebMock's Typhoeus adapter bypasses Typhoeus::EasyFactory, where the cap lives, so these examples
# go through a real socket.
describe WPScan::ResponseSizeCap do
  let(:body_size) { 1024 * 1024 }
  let(:chunk)     { 'a' * 16 * 1024 }

  let!(:server) { TCPServer.new('127.0.0.1', 0) }
  let(:url)     { "http://127.0.0.1:#{server.addr[1]}/" }

  let!(:server_thread) do
    Thread.new do
      loop do
        client = server.accept
        serve(client)
      rescue IOError
        break
      end
    end
  end

  def serve(client)
    if client.readpartial(4096).start_with?('GET /redirect ')
      client.write("HTTP/1.1 302 Found\r\nLocation: #{url}\r\nContent-Length: 0\r\nConnection: close\r\n\r\n")
      return
    end

    client.write("HTTP/1.1 200 OK\r\nTransfer-Encoding: chunked\r\nConnection: close\r\n\r\n")
    (body_size / chunk.bytesize).times { client.write("#{chunk.bytesize.to_s(16)}\r\n#{chunk}\r\n") }
    client.write("0\r\n\r\n")
  rescue Errno::EPIPE, Errno::ECONNRESET
    nil # The client aborted the transfer
  ensure
    client.close
  end

  before do
    WebMock.disable_net_connect!(allow_localhost: true)
    WPScan.truncated_responses = []
  end

  after do
    WebMock.disable_net_connect!
    WPScan.truncated_responses = []
    server.close
    server_thread.join
  end

  def run_request(max_response_size, request_url = url, **params)
    request = Typhoeus::Request.new(request_url, params)
    request.max_response_size = max_response_size
    yield request if block_given?
    request.run
  end

  context 'when no cap' do
    it 'reads the whole body' do
      [nil, 0].each do |max|
        expect(run_request(max).body.bytesize).to eql body_size
      end
    end
  end

  context 'when the body is under the cap' do
    it 'reads the whole body, without recording it as truncated' do
      expect(run_request(body_size * 2).body.bytesize).to eql body_size
      expect(WPScan.truncated_responses).to be_empty
    end
  end

  context 'when the body exceeds the cap' do
    let(:max) { 100 * 1024 }

    it 'stops reading once the cap is reached, keeping the status code' do
      response = run_request(max)

      expect(response.code).to eql 200
      expect(response.body.bytesize).to be >= max
      expect(response.body.bytesize).to be < body_size
    end

    it 'records the URL of each truncated response' do
      2.times { run_request(max) }

      expect(WPScan.truncated_responses).to eql [url, url]
    end

    it 'records the URL the body came from, after redirects' do
      run_request(max, "#{url}redirect", followlocation: true)

      expect(WPScan.truncated_responses).to eql [url]
    end

    it 'caches the truncated body rather than an empty one' do
      cache = Class.new do
        attr_reader :cached_body

        def get(_request) = nil

        def set(_request, response)
          @cached_body = response.body.dup
        end
      end.new

      run_request(max, cache: cache)

      expect(cache.cached_body.bytesize).to be >= max
    end

    it 'does not serve the truncated body to a request with a higher cap' do
      cache = Class.new do
        def initialize = @store = {}
        def get(request) = @store[request.hash]
        def set(request, response) = @store[request.hash] = response
      end.new

      run_request(max, cache: cache)

      expect(run_request(body_size * 2, cache: cache).body.bytesize).to eql body_size
    end

    it 'leaves a request which streams its own body alone' do
      streamed = +''

      run_request(max) { |request| request.on_body { |chunk| streamed << chunk } }

      expect(streamed.bytesize).to eql body_size
    end
  end
end
