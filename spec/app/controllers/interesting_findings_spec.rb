# frozen_string_literal: true

describe WPScan::Controller::InterestingFindings do
  subject(:controller) { described_class.new }
  let(:target_url)     { 'http://example.com/' }
  let(:cli_args)       { "--url #{target_url}" }

  before do
    WPScan::ParsedCli.options = rspec_parsed_options(cli_args)
  end

  its(:before_scan) { should be_nil }
  its(:after_scan)  { should be_nil }

  describe '#cli_options' do
    its(:cli_options) { should_not be_empty }
    its(:cli_options) { should be_a Array }

    it 'contains the correct options' do
      expect(controller.cli_options.map(&:to_sym)).to eq [:interesting_findings_detection]
    end
  end

  describe '#run' do
    before do
      expect(controller.target).to receive(:interesting_findings)
        .with(
          mode: WPScan::ParsedCli.interesting_findings_detection ||
                WPScan::ParsedCli.detection_mode
        ).and_return(stubbed)
    end

    after { controller.run }

    %i[mixed passive aggressive].each do |mode|
      context "when --detection-mode #{mode}" do
        let(:cli_args) { "#{super()} --detection-mode #{mode}" }

        context 'when no findings' do
          let(:stubbed) { [] }

          before { expect(controller.formatter).to_not receive(:output) }

          it 'does not call the formatter' do
            # Handled by the before statements above
          end

          context 'when --interesting-findings-detection mode supplied' do
            let(:cli_args) { "#{super()} --interesting-findings-detection passive" }

            it 'gives the correct detection parameter' do
              # Handled by before/after statements
            end
          end
        end

        context 'when findings' do
          let(:stubbed) { ['yolo'] }

          it 'calls the formatter with the correct parameter' do
            expect(controller.formatter).to receive(:output)
              .with('findings', hash_including(findings: stubbed), 'interesting_findings')
          end
        end
      end
    end
  end
end
