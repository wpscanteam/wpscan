# frozen_string_literal: true

module WPScan
  module Controller
    # InterestingFindings Controller
    class InterestingFindings < Base
      def cli_options
        [
          OptChoice.new(
            ['--interesting-findings-detection MODE',
             'Use the supplied mode for the interesting findings detection. '],
            choices: %w[mixed passive aggressive], normalize: :to_sym, advanced: true
          )
        ]
      end

      def run
        mode = WPScan::ParsedCli.interesting_findings_detection || WPScan::ParsedCli.detection_mode
        findings = target.interesting_findings(mode: mode)

        output('findings', findings: findings) unless findings.empty?
      end
    end
  end
end
