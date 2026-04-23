# frozen_string_literal: true

describe WPScan::Finders::Finder::SmartURLChecker do
  # Dummy class to test the module
  class DummySmartURLCheckerFinder < WPScan::Finders::Finder
    include WPScan::Finders::Finder::SmartURLChecker
  end

  subject(:finder) { DummySmartURLCheckerFinder.new(target) }
  let(:target)     { WPScan::Target.new('http://e.org') }

  before { stub_request(:get, target.url) }

  context 'when methods are not implemented' do
    it 'raises errors' do
      expect { finder.process_urls([]) }.to raise_error NotImplementedError
      expect { finder.passive }.to raise_error NotImplementedError
      expect { finder.aggressive_urls }.to raise_error NotImplementedError
    end
  end

  describe '#aggressive' do
    before { expect(finder).to receive(:aggressive_urls).and_return(%w[u1 u2 u3]) }

    after do
      expect(finder).to receive(:process_urls).with(@expected_urls, { mode: mode })
      finder.aggressive(mode: mode)
    end

    context 'when :mode = :mixed' do
      before { expect(finder).to receive(:passive_urls).and_return(%w[u2]) }

      let(:mode) { :mixed }

      it 'calls #process_urls with the correct argument' do
        @expected_urls = %w[u1 u3]
      end
    end

    %i[passive aggressive].each do |m|
      context "when :mode = #{m}" do
        let(:mode) { m }

        it 'calls #process_urls with the correct argument' do
          @expected_urls = %w[u1 u2 u3]
        end
      end
    end
  end
end
