# frozen_string_literal: true

describe WPScan::Controller::Aliases do
  subject(:controller) { described_class.new }
  let(:target_url)     { 'http://ex.lo/' }
  let(:parsed_options) { rspec_parsed_options(cli_args) }
  let(:cli_args)       { "--url #{target_url}" }

  before do
    WPScan::Browser.reset
    described_class.parsed_options = parsed_options
  end

  describe '#cli_options' do
    its(:cli_options) { should_not be_empty }
    its(:cli_options) { should be_a Array }

    it 'contains to correct options' do
      expect(controller.cli_options.map(&:to_sym)).to eq %i[stealthy]
    end
  end

  describe 'parsed_options' do
    context 'when no --stealthy supplied' do
      its(:parsed_options) { should eql parsed_options }
    end

    context 'when --stealthy supplied' do
      let(:cli_args) { "#{super()} --stealthy" }

      it 'contains the correct options' do
        expect(controller.parsed_options).to include(
          random_user_agent: true, detection_mode: :passive, plugins_version_detection: :passive
        )
      end
    end
  end
end
