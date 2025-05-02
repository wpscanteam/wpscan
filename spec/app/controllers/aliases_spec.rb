# frozen_string_literal: true

describe WPScan::Controller::Aliases do
  subject(:controller) { described_class.new }
  let(:target_url)     { 'http://ex.lo/' }
  let(:cli_args)       { "--url #{target_url}" }

  before do
    WPScan::ParsedCli.options = rspec_parsed_options(cli_args)
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
      it 'contains the correct options' do
        expect(WPScan::ParsedCli.options).to include(detection_mode: :mixed)
      end
    end

    context 'when --stealthy supplied' do
      let(:cli_args) { "#{super()} --stealthy" }

      it 'contains the correct options' do
        expect(WPScan::ParsedCli.options).to include(random_user_agent: true, detection_mode: :passive)
      end
    end
  end
end
