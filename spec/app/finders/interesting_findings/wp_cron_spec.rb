# frozen_string_literal: true

describe WPScan::Finders::InterestingFindings::WPCron do
  subject(:finder) { described_class.new(target) }
  let(:target)     { WPScan::Target.new(url) }
  let(:url)        { 'http://ex.lo/' }
  let(:wp_content) { 'wp-content' }

  before { expect(target).to receive(:sub_dir).at_least(1).and_return(false) }

  describe '#aggressive' do
    before { stub_request(:get, finder.wp_cron_url).to_return(status: status) }

    context 'when 200' do
      let(:status) { 200 }

      it 'returns the InterestingFinding' do
        expect(finder.aggressive).to eql WPScan::Model::WPCron.new(
          finder.wp_cron_url,
          confidence: 60,
          found_by: described_class::DIRECT_ACCESS
        )
      end
    end

    context 'otherwise' do
      let(:status) { 403 }

      its(:aggressive) { should be_nil }
    end
  end
end
