# frozen_string_literal: true

describe WPScan::Target do
  subject(:target) { described_class.new(url, opts) }
  let(:url)        { 'http://ex.lo' }
  let(:opts)       { {} }

  it_behaves_like WPScan::Target::Platform::WordPress

  describe 'xmlrpc' do
    before do
      allow(target).to receive(:sub_dir)

      expect(target).to receive(:interesting_findings).and_return(interesting_findings)
    end

    context 'when no interesting_findings' do
      let(:interesting_findings) { [] }

      its(:xmlrpc) { should be_nil }
    end

    context 'when interesting_findings' do
      let(:interesting_findings) { ['aa', WPScan::Model::RobotsTxt.new(target.url)] }

      context 'when no XMLRPC' do
        its(:xmlrpc) { should be_nil }
      end

      context 'when XMLRPC' do
        let(:xmlrpc) { WPScan::Model::XMLRPC.new(target.url('xmlrpc.php')) }
        let(:interesting_findings) { super() << xmlrpc }

        its(:xmlrpc) { should eq xmlrpc }
      end
    end
  end

  %i[wp_version main_theme plugins themes timthumbs config_backups db_exports medias users].each do |method|
    describe "##{method}" do
      let(:methods) { %i[wp_version main_theme] }

      before do
        return_value = methods.include?(method) ? false : []

        expect(WPScan::Finders.const_get("#{method.to_s.camelize}::Base"))
          .to receive(:find).with(target, opts).and_return(return_value)
      end

      after { target.send(method, opts) }

      let(:opts) { {} }

      context 'when no options' do
        it 'calls the finder with the correct arguments' do
          # handled by before hook
        end
      end

      context 'when options' do
        let(:opts) { { mode: :passive, somthing: 'k' } }

        it 'calls the finder with the corect arguments' do
          # handled by before hook
        end
      end

      context 'when called multiple times' do
        it 'calls the finder only once' do
          target.send(method, opts)
        end
      end
    end
  end

  describe '#url_pattern' do
    its(:url_pattern) { should eql %r{https?:\\?/\\?/ex\.lo\\?/}i }
    its(:url_pattern) { should match 'https:\/\/ex.lo\/' }
  end

  describe '#comments_from_page' do
    let(:fixtures) { FIXTURES.join('target') }
    let(:fixture) { fixtures.join('comments.html') }
    let(:page) { Typhoeus::Response.new(body: File.read(fixture)) }

    context 'when the pattern does not match anything' do
      it 'returns an empty array' do
        expect(target.comments_from_page(/none/, page)).to eql([])
      end
    end

    context 'when the pattern matches' do
      let(:pattern) { /all in one seo pack/i }
      let(:s1) { 'All in One SEO Pack 2.2.5.1 by Michael Torbert of Semper Fi Web Design' }
      let(:s2) { '/all in one seo pack' }

      context 'when no block given' do
        it 'returns the expected matches' do
          results = target.comments_from_page(pattern, page)

          [s1, s2].each_with_index do |s, i|
            expect(results[i].first).to eql s.match(pattern)
            expect(results[i].last.to_s).to eql "<!-- #{s} -->"
          end
        end
      end

      context 'when block given' do
        it 'yield the MatchData' do
          expect { |b| target.comments_from_page(pattern, page, &b) }
            .to yield_successive_args(
              [MatchData, Nokogiri::XML::Comment],
              [MatchData, Nokogiri::XML::Comment]
            )
        end
      end
    end

    context 'when invalid byte sequence' do
      let(:page) { Typhoeus::Response.new(body: "<!-- \xEB -->") }

      it 'does not raise an error' do
        expect { target.comments_from_page(/none/, page) }.to_not raise_error
      end
    end
  end

  describe '#javascripts_from_page' do
    let(:fixtures) { FIXTURES.join('target') }
    let(:fixture) { fixtures.join('javascripts.html') }
    let(:page)    { Typhoeus::Response.new(body: File.read(fixture)) }

    context 'when the pattern does not match anything' do
      it 'returns an empty array' do
        expect(target.javascripts_from_page(/none/, page)).to eql([])
      end
    end

    context 'when the pattern matches' do
      let(:pattern) { /_version =/i }
      let(:s)       { "var _version = '1.2.4';" }

      context 'when no block given' do
        it 'returns the expected matches' do
          results = target.javascripts_from_page(pattern, page)

          expect(results[0].first).to eql s.match(pattern)
          expect(results[0].last.text.to_s).to eql s
        end
      end

      context 'when block given' do
        it 'yield the MatchData' do
          expect { |b| target.javascripts_from_page(pattern, page, &b) }
            .to yield_successive_args(
              [MatchData, Nokogiri::XML::Element]
            )
        end
      end
    end
  end

  describe '#uris_from_page' do
    let(:fixtures) { FIXTURES.join('target') }
    let(:page) { Typhoeus::Response.new(body: File.read(fixtures.join('uris_from_page.html'))) }
    let(:url) { 'http://e.org' }

    context 'when block given' do
      it 'yield the url' do
        expect { |b| target.uris_from_page(page, &b) }
          .to yield_successive_args(
            [Addressable::URI.parse('http://e.org/f.txt'), Nokogiri::XML::Element],
            [Addressable::URI.parse('https://cdn.e.org/f2.js'), Nokogiri::XML::Element],
            [Addressable::URI.parse('http://e.org/script/s.js'), Nokogiri::XML::Element],
            [Addressable::URI.parse('http://wp-lamp/feed.xml'), Nokogiri::XML::Element],
            [Addressable::URI.parse('http://g.com/img.jpg'), Nokogiri::XML::Element],
            [Addressable::URI.parse('http://g.org/logo.png'), Nokogiri::XML::Element]
          )
      end
    end

    context 'when no block given' do
      it 'returns the expected array' do
        expect(target.uris_from_page(page)).to eql(
          %w[
            http://e.org/f.txt https://cdn.e.org/f2.js http://e.org/script/s.js
            http://wp-lamp/feed.xml http://g.com/img.jpg http://g.org/logo.png
          ].map { |u| Addressable::URI.parse(u) }
        )
      end
    end
  end

  describe '#vulnerable?' do
    context 'when all attributes are nil' do
      it { should_not be_vulnerable }
    end

    context 'when wp_version is not found' do
      before { target.instance_variable_set(:@wp_version, false) }

      it { should_not be_vulnerable }
    end

    context 'when wp_version found' do
      before do
        expect(wp_version)
          .to receive(:db_data)
          .and_return(vuln_api_data_for("wordpresses/#{wp_version.number.tr('.', '')}"))

        target.instance_variable_set(:@wp_version, wp_version)
      end

      context 'when not vulnerable' do
        let(:wp_version) { WPScan::Model::WpVersion.new('4.0') }

        it { should_not be_vulnerable }
      end

      context 'when vulnerable' do
        let(:wp_version) { WPScan::Model::WpVersion.new('3.8.1') }

        it { should be_vulnerable }
      end
    end

    context 'when config_backups' do
      before do
        target.instance_variable_set(:@config_backups, [WPScan::Model::ConfigBackup.new(target.url('/a-file-url'))])
      end

      it { should be_vulnerable }
    end

    context 'when db_exports' do
      before do
        target.instance_variable_set(:@db_exports, [WPScan::Model::DbExport.new(target.url('/wordpress.sql'))])
      end

      it { should be_vulnerable }
    end

    context 'when users' do
      before do
        target.instance_variable_set(:@users,
                                     [WPScan::Model::User.new('u1'),
                                      WPScan::Model::User.new('u2')])
      end

      context 'when no passwords' do
        it { should_not be_vulnerable }
      end

      context 'when at least one password has been found' do
        before { target.users[1].password = 'owned' }

        it { should be_vulnerable }
      end
    end
  end
end
