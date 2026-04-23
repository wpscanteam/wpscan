# frozen_string_literal: true

describe WPScan::Target do
  subject(:target) { described_class.new(url, opts) }
  let(:url)        { 'http://e.org' }
  let(:fixtures)   { FIXTURES.join('target', 'scope') }
  let(:opts)       { { scope: nil } }

  before { stub_request(:get, /e\.org/) }

  describe '#scope' do
    let(:default_domains) { [PublicSuffix.parse('e.org')] }

    context 'when none supplied' do
      its('scope.domains') { should eq default_domains }
    end

    context 'when scope provided' do
      let(:opts) { super().merge(scope: ['*.e.org']) }

      its('scope.domains') { should eq default_domains << PublicSuffix.parse(opts[:scope].first) }

      context 'when invalid domains provided' do
        let(:opts) { super().merge(scope: ['wp-lamp']) }

        it 'adds them in the invalid_domains attribute' do
          expect(target.scope.domains).to eq default_domains
          expect(target.scope.invalid_domains).to eq opts[:scope]
        end
      end
    end
  end

  describe '#in_scope?' do
    context 'when default scope (target domain)' do
      [nil, '', 'http://out-of-scope.com', '//jquery.com/j.js',
       'javascript:alert(3)', 'mailto:p@g.com',
       Addressable::URI.parse('https://out.cloudfront.net')].each do |url|
        it "returns false for #{url}" do
          expect(target.in_scope?(url)).to eql false
        end
      end

      ['https://e.org/file.txt', 'http://e.org/', '//e.org', Addressable::URI.parse('http://e.org')].each do |url|
        it "returns true for #{url}" do
          expect(target.in_scope?(url)).to eql true
        end
      end
    end

    context 'when custom scope' do
      let(:opts) { { scope: ['*.cdn.com', '192.168.1.12', '*.cloudfront.net'] } }

      [nil, '', 'http://out-of-scope.com', '//jquery.com/j.js', 'http://192.168.1.2/'].each do |url|
        it "returns false for #{url}" do
          expect(target.in_scope?(url)).to eql false
        end
      end

      %w[
        https://e.org //aa.cdn.com/f.txt http://s.cdn.com/
        https://192.168.1.12/h https://aa.cloudfront.net/
      ].each do |url|
        it "returns true for #{url}" do
          expect(target.in_scope?(url)).to eql true
        end
      end
    end
  end

  describe '#in_scope_uris' do
    let(:res) { Typhoeus::Response.new(body: File.read(fixtures.join('index.html'))) }

    context 'when block given' do
      it 'yield the url' do
        expect { |b| target.in_scope_uris(res, &b) }
          .to yield_successive_args(
            [Addressable::URI.parse('http://e.org/f.txt'), Nokogiri::XML::Element],
            [Addressable::URI.parse('http://e.org/script/s.js'), Nokogiri::XML::Element],
            [Addressable::URI.parse('http://e.org/feed'), Nokogiri::XML::Element]
          )
      end
    end

    context 'when no block given' do
      after { expect(target.in_scope_uris(res)).to eql @expected }

      context 'when default scope' do
        it 'returns the expected array' do
          @expected = %w[http://e.org/f.txt http://e.org/script/s.js
                         http://e.org/feed].map { |u| Addressable::URI.parse(u) }
        end
      end

      context 'when supplied scope' do
        let(:opts) { super().merge(scope: ['*.cdn.com', 'wp-lamp']) }

        it 'returns the expected array' do
          @expected = %w[http://e.org/f.txt https://a.cdn.com/f2.js http://e.org/script/s.js
                         http://wp-lamp/robots.txt http://e.org/feed].map { |u| Addressable::URI.parse(u) }
        end
      end
    end
  end

  describe '#scope_url_pattern' do
    context 'when no scope given' do
      its(:scope_url_pattern) { should eql %r{https?:\\?/\\?/(?:e\.org)\\?/?}i }

      context 'when target is an invalid domain for PublicSuffix' do
        let(:url) { 'http://wp_lab/' }

        before { stub_request(:get, /wp_lab/) }

        its(:scope_url_pattern) { should eql %r{https?:\\?/\\?/(?:wp_lab)\\?/?}i }
      end

      context 'when a port is present in the target URL' do
        let(:url) { 'http://wp.lab:82/aa' }

        before { stub_request(:get, /wp\.lab/) }

        its(:scope_url_pattern) { should eql %r{https?:\\?/\\?/(?:wp\.lab(?::\d+)?\\?/aa)\\?/?}i }
        its(:scope_url_pattern) { should match 'https://wp.lab:82/aa' }
      end
    end

    context 'when scope given' do
      let(:opts) { super().merge(scope: ['*.cdn.org', 'wp_lamp', '192.168.1.1']) }

      its(:scope_url_pattern) { should eql %r{https?:\\?/\\?/(?:e\.org|.*\.cdn\.org|192\.168\.1\.1|wp_lamp)\\?/?}i }
    end
  end
end
