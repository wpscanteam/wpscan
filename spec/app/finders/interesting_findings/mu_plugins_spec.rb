# frozen_string_literal: true

describe WPScan::Finders::InterestingFindings::MuPlugins do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url).extend(CMSScanner::Target::Server::Apache) }
  let(:url)        { 'http://ex.lo/' }
  let(:fixtures)   { FINDERS_FIXTURES.join('interesting_findings', 'mu_plugins') }

  before do
    expect(target).to receive(:content_dir).at_least(1).and_return('wp-content')
  end

  describe '#passive' do
    before { stub_request(:get, url).to_return(body: body) }

    context 'when no uris' do
      let(:body) { '' }

      its(:passive) { should be nil }
    end

    context 'when a large amount of unrelated uris' do
      let(:body) do
        Array.new(250) { |i| "<a href='#{url}#{i}.html'>Some Link</a><img src='#{url}img-#{i}.png'/>" }.join("\n")
      end

      it 'should not take a while to process the page' do
        time_start = Time.now
        result = finder.passive
        time_end = Time.now

        expect(result).to be nil
        expect(time_end - time_start).to be < 1
      end
    end

    context 'when uris' do
      let(:body) { File.read(fixtures.join(fixture)) }

      context 'when none matching' do
        let(:fixture) { 'no_match.html' }

        its(:passive) { should be nil }
      end

      context 'when matching via href' do
        let(:fixture) { 'match_href.html' }

        its(:passive) { should be_a WPScan::Model::MuPlugins }
      end

      context 'when matching from src' do
        let(:fixture) { 'match_src.html' }

        its(:passive) { should be_a WPScan::Model::MuPlugins }
      end
    end
  end

  describe '#aggressive' do
    xit
  end
end
