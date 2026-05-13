# frozen_string_literal: true

module WPScan
  # Controllers container. Summary width is 45 (wpscan-specific; upstream default was 40).
  class Controllers < Array
    attr_reader :option_parser, :running

    # @param [ OptParseValidator::OptParser ] option_parser
    def initialize(option_parser = OptParseValidator::OptParser.new(nil, 45))
      @option_parser = option_parser

      register_config_files

      option_parser.config_files.result_key = 'cli_options'
    end

    # Registers the potential option-file paths with the option_parser.
    def register_config_files
      [Dir.home, Dir.pwd].each do |dir|
        option_parser.config_files.class.supported_extensions.each do |ext|
          option_parser.config_files << Pathname.new(dir).join(".#{WPScan.app_name}", "scan.#{ext}").to_s
        end
      end
    end

    # @param [ Controller::Base ] controller
    #
    # @return [ Controllers ] self
    def <<(controller)
      options = controller.cli_options

      unless include?(controller)
        option_parser.add(*options) if options
        super
      end
      self
    end

    # Force the non-colored CLI formatter when ANSI escapes would be
    # unwanted: writing to a file, piping to another process, or when the
    # caller has set NO_COLOR (see https://no-color.org). Explicit
    # --format choices are preserved.
    def apply_no_colour_default
      return if WPScan::ParsedCli.options[:format]

      no_color = ENV.fetch('NO_COLOR', nil)
      return unless WPScan::ParsedCli.output || !$stdout.tty? || (no_color && !no_color.empty?)

      WPScan::ParsedCli.options[:format] = 'cli-no-colour'
    end

    def run
      WPScan::ParsedCli.options = option_parser.results
      first.class.option_parser = option_parser # needed to output help on -h/--hh

      apply_no_colour_default
      redirect_output_to_file(WPScan::ParsedCli.output) if WPScan::ParsedCli.output

      Timeout.timeout(WPScan::ParsedCli.max_scan_duration, WPScan::Error::MaxScanDurationReached) do
        each(&:before_scan)

        @running = true

        each(&:run)
      end
    ensure
      # The rescue prevents unfinished requests from raising, which would stop reverse_each from running.
      # rubocop:disable Style/RescueModifier
      WPScan::Browser.instance.hydra.abort rescue nil
      # rubocop:enable Style/RescueModifier

      # Reverse order: app/controllers/core#after_scan finishes the output and must be last.
      # Guarantees stats are output even on error. after_scan runs only if scan was actually running
      # (skipped on CLI error, -h/--hh/--version).
      reverse_each(&:after_scan) if running
    end
  end
end
