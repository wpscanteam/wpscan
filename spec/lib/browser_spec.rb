# frozen_string_literal: true

describe WPScan::Browser do
  subject(:browser) { described_class.instance(options) }
  let(:options)     { {} }

  before            { described_class.reset }

  describe '#user_agent' do
    context 'when not set' do
      its(:user_agent) { should eq "WPScan v#{WPScan::VERSION} (https://wpscan.org/)" }
    end

    context 'when set' do
      let(:options) { super().merge(user_agent: 'Custom UA') }

      its(:user_agent) { should eq options[:user_agent] }
    end
  end
end
