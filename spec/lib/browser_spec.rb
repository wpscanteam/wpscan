require 'spec_helper'

describe WPScan::Browser do
  subject(:browser) { described_class.instance(options) }
  before            { described_class.reset }
  let(:options)     { {} }

  describe '#user_agents_list' do
    context 'when not set' do
      its(:user_agents_list) { should eql File.join(WPScan::DB_DIR, 'user-agents.txt') }
    end

    context 'when set' do
      let(:options) { super().merge(user_agents_list: 'test.txt') }

      its(:user_agents_list) { should eql 'test.txt' }
    end
  end

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
