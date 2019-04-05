# frozen_string_literal: true

def it_calls_the_formatter_with_the_correct_parameter(version)
  it 'calls the formatter with the correct parameter' do
    expect(controller.formatter).to receive(:output)
      .with('version', hash_including(version: version), 'wp_version')
  end
end

describe WPScan::Finders::WpVersionFinders do
  subject(:finders) { described_class.new }

  describe 'filter_findings' do
    context 'when super returns false (nothing found)' do
      before do
        expect_any_instance_of(WPScan::Finders::UniqueFinders).to receive(:filter_findings).and_return(false)
      end

      its(:filter_findings) { should be false }
    end
  end
end

describe WPScan::Controller::WpVersion do
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
      expect(controller.cli_options.map(&:to_sym)).to eq %i[wp_version_all wp_version_detection]
    end
  end

  describe '#run' do
    before do
      expect(controller.target).to receive(:wp_version)
        .with(
          hash_including(
            mode: WPScan::ParsedCli.wp_version_detection || WPScan::ParsedCli.detection_mode,
            confidence_threshold: WPScan::ParsedCli.wp_version_all ? 0 : 100
          )
        ).and_return(stubbed)
    end

    after { controller.run }

    %i[mixed passive aggressive].each do |mode|
      context "when --detection-mode #{mode}" do
        let(:cli_args) { "#{super()} --detection-mode #{mode}" }

        [WPScan::Model::WpVersion.new('4.0')].each do |version|
          context "when version = #{version}" do
            let(:stubbed) { version }

            it_calls_the_formatter_with_the_correct_parameter(version)
          end
        end
      end
    end

    context 'when --wp-version-all supplied' do
      let(:cli_args) { "#{super()} --wp-version-all" }
      let(:stubbed) { WPScan::Model::WpVersion.new('3.9.1') }

      it_calls_the_formatter_with_the_correct_parameter(WPScan::Model::WpVersion.new('3.9.1'))
    end

    context 'when --wp-version-detection mode supplied' do
      let(:cli_args) { "#{super()} --detection-mode mixed --wp-version-detection passive" }
      let(:stubbed) { WPScan::Model::WpVersion.new('4.4') }

      it_calls_the_formatter_with_the_correct_parameter(WPScan::Model::WpVersion.new('4.4'))
    end
  end
end
