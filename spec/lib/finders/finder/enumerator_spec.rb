# frozen_string_literal: true

describe WPScan::Finders::Finder::Enumerator do
  # Dummy class to test the module
  class DummyEnumeratorFinder < WPScan::Finders::Finder
    include WPScan::Finders::Finder::Enumerator
  end

  subject(:finder) { DummyEnumeratorFinder.new(target) }
  let(:target)     { WPScan::Target.new('http://e.org') }

  before do
    stub_request(:get, /e\.org/)
    allow(target).to receive(:head_or_get_params).and_return(method: :head)
  end

  its(:head_or_get_request_params) { should eql(method: :head, cache_ttl: 0) }
  its(:valid_response_codes)       { should eql [200] }
  its(:full_request_params)        { should eql({}) }

  describe '#maybe_get_full_response' do
    let(:head_res)      { Typhoeus::Response.new(code: 200, effective_url: effective_url) }
    let(:effective_url) { target.url('maybe_get_full_response') }
    let(:opts)          { {} }

    context 'when check_full_response is false/nil' do
      it 'returns the head response' do
        expect(finder.maybe_get_full_response(head_res, {})).to eql head_res
        expect(finder.maybe_get_full_response(head_res, check_full_response: false)).to eql head_res
      end
    end

    context 'when check_full_response is true' do
      let(:opts)   { super().merge(check_full_response: true) }
      let(:body)   { '' }
      let(:status) { 200 }

      before { stub_request(:get, effective_url).to_return(body: body, status: status) }

      context 'when the body matches the 404 homepage' do
        it 'returns nil' do
          expect(target).to receive(:homepage_or_404?).and_return(true)

          expect(finder.maybe_get_full_response(head_res, opts)).to eql nil
        end
      end

      context 'when the status is not valid' do
        let(:status) { 404 }

        it 'returns nil' do
          allow(target).to receive(:homepage_or_404?).and_return(false)

          expect(finder.maybe_get_full_response(head_res, opts)).to eql nil
        end
      end

      context 'when the exclude_content is set' do
        before { expect(target).to receive(:homepage_or_404?).and_return(false) }

        let(:opts) { super().merge(exclude_content: /ignored/) }

        context 'when the body matches' do
          let(:body) { 'should be ignored' }

          it 'returns nil' do
            expect(finder.maybe_get_full_response(head_res, opts)).to eql nil
          end
        end

        context 'when the body does not match' do
          let(:body) { 'should pass' }

          it 'returns the GET response' do
            res = finder.maybe_get_full_response(head_res, opts)

            expect(res).to be_a Typhoeus::Response
            expect(res.request.options[:method]).to eql :get
            expect(res.body).to eql body
          end
        end
      end

      context 'when not 404 and no exclude_content' do
        before { expect(target).to receive(:homepage_or_404?).and_return(false) }

        it 'returns the GET response' do
          res = finder.maybe_get_full_response(head_res, opts)

          expect(res).to be_a Typhoeus::Response
          expect(res.request.options[:method]).to eql :get
          expect(res.body).to eql body
        end
      end
    end

    context 'when check_full_response is an array of status codes' do
      let(:opts) { super().merge(check_full_response: [200]) }

      context 'when the head_res status is not in the array' do
        let(:head_res) { Typhoeus::Response.new(code: 400, effective_url: effective_url) }

        it 'returns the HEAD response' do
          expect(finder.maybe_get_full_response(head_res, opts)).to eql head_res
        end
      end

      context 'when the head_res status is in the array' do
        let(:head_res) { Typhoeus::Response.new(code: 200, effective_url: effective_url) }

        before do
          stub_request(:get, effective_url).to_return(body: 'body')

          expect(target).to receive(:homepage_or_404?).and_return(false)
        end

        it 'returns the GET response' do
          res = finder.maybe_get_full_response(head_res, opts)

          expect(res).to be_a Typhoeus::Response
          expect(res.request.options[:method]).to eql :get
          expect(res.body).to eql 'body'
        end
      end
    end

    context 'when check_full_response is a status code (string)' do
      let(:opts) { super().merge(check_full_response: 200) }

      context 'when the head_res status has not the same status' do
        let(:head_res) { Typhoeus::Response.new(code: 400, effective_url: effective_url) }

        it 'returns the HEAD response' do
          expect(finder.maybe_get_full_response(head_res, opts)).to eql head_res
        end
      end

      context 'when the head_res status has the same status' do
        let(:head_res) { Typhoeus::Response.new(code: 200, effective_url: effective_url) }

        before do
          stub_request(:get, effective_url).to_return(body: 'body')

          expect(target).to receive(:homepage_or_404?).and_return(false)
        end

        it 'returns the GET response' do
          res = finder.maybe_get_full_response(head_res, opts)

          expect(res).to be_a Typhoeus::Response
          expect(res.request.options[:method]).to eql :get
          expect(res.body).to eql 'body'
        end
      end
    end
  end

  describe '#enumerate' do
    let(:target_urls) do
      {
        target.url('1') => 1,
        target.url('2') => 2
      }
    end

    let(:opts) { {} }

    context ' when no opts' do
      context 'when all HEADS are 404' do
        before do
          target_urls.each_key do |url|
            stub_request(:head, url).to_return(status: 404)
          end
        end

        it 'does not yield anything' do
          expect { |b| finder.enumerate(target_urls, opts, &b) }.to_not yield_control
        end
      end

      context 'when some pages are 200 (default valid_response_codes)' do
        before do
          stub_request(:head, target_urls.key(1)).to_return(status: 404)

          stub_request(:head, target_urls.key(2)).to_return(status: 200)
          stub_request(:get, target_urls.key(2)).to_return(status: 200, body: 'rspec')
        end

        it 'yield the expected item' do
          expect { |b| finder.enumerate(target_urls, opts, &b) }.to yield_with_args(Typhoeus::Response, 2)
        end
      end
    end

    context 'when opts' do
      context 'when :exclude_content' do
        before do
          target_urls.each_key do |url|
            stub_request(:head, url).to_return(status: 200, headers: { 'Key' => 'aa' })
          end
        end

        context 'when header matches' do
          let(:opts) { super().merge(exclude_content: /Key: aa/i) }

          it 'does not yield anything' do
            expect { |b| finder.enumerate(target_urls, opts, &b) }.to_not yield_control
          end
        end

        context 'when header does not match' do
          let(:opts) { super().merge(exclude_content: /not aa/i) }

          before do
            target_urls.each_key { |url| stub_request(:get, url).to_return(status: 200) }
          end

          it 'yield the expected items' do
            expect { |b| finder.enumerate(target_urls, opts, &b) }.to yield_successive_args(
              [Typhoeus::Response, 1], [Typhoeus::Response, 2]
            )
          end
        end

        context 'when one header matches but the other not, using negative look-arounds' do
          let(:opts) { super().merge(exclude_content: /\A((?!x-cacheable)[\s\S])*\z/i) }

          before do
            stub_request(:head, target_urls.keys.last).and_return(status: 200, headers: { 'x-cacheable' => 'YES' })
          end

          it 'yield the expected item' do
            expect { |b| finder.enumerate(target_urls, opts, &b) }.to yield_with_args(Typhoeus::Response, 2)
          end
        end
      end

      context 'when check_full_response' do
        let(:opts) { super().merge(check_full_response: true) }

        before do
          target_urls.each_key do |url|
            stub_request(:head, url).to_return(status: 200)
          end
        end

        context 'when #maybe_get_full_response returns nil' do
          it 'does not yield anything' do
            expect(finder).to receive(:maybe_get_full_response).twice.and_return(nil)

            expect { |b| finder.enumerate(target_urls, opts, &b) }.to_not yield_control
          end
        end

        context 'when #check_full_response' do
          it 'yields the GET responses' do
            expect(finder)
              .to receive(:maybe_get_full_response)
              .twice
              .and_return(Typhoeus::Response.new(code: 200))

            expect { |b| finder.enumerate(target_urls, opts, &b) }.to yield_successive_args(
              [Typhoeus::Response, 1], [Typhoeus::Response, 2]
            )
          end
        end
      end
    end
  end
end
