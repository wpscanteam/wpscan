# frozen_string_literal: true

module WPScan
  # Scan
  class Scan
    attr_reader :run_error

    def initialize
      WPScan.start_memory = GetProcessMem.new.bytes

      controllers << WPScan::Controller::Core.new

      exit_hook

      yield self if block_given?
    end

    # @return [ Controllers ]
    def controllers
      @controllers ||= WPScan::Controllers.new
    end

    def run
      controllers.run
    rescue OptParseValidator::NoRequiredOption => e
      @run_error = e

      formatter.output('@usage', msg: e.message)
    rescue NoMemoryError, ScriptError, SecurityError, SignalException, StandardError, SystemStackError => e
      @run_error = e

      output_params = {
        reason: e.is_a?(Interrupt) ? 'Canceled by User' : e.message,
        trace: e.backtrace,
        verbose: WPScan::ParsedCli.verbose || run_error_exit_code == WPScan::ExitCode::EXCEPTION
      }

      output_params[:url] = controllers.first.target.url if WPScan::ParsedCli.url

      formatter.output(aborted_view, output_params)
    ensure
      formatter.beautify
    end

    # Used for convenience
    # @See Formatter
    def formatter
      controllers.first.formatter
    end

    # @return [ String ] The global view to render when the run is aborted
    def aborted_view
      core = controllers.first
      core.respond_to?(:updating_db?) && core.updating_db? ? '@update_aborted' : '@scan_aborted'
    end

    # @return [ Hash ]
    def datastore
      controllers.first.datastore
    end

    # Hook to be able to have an exit code returned
    # depending on the findings / errors
    # :nocov:
    def exit_hook
      # Avoid hooking the exit when rspec is running, otherwise it will always return 0
      # and Travis won't detect failed builds. Couldn't find a better way, even though
      # some people managed to https://github.com/rspec/rspec-core/pull/410
      return if defined?(RSpec)

      at_exit do
        exit(run_error_exit_code) if run_error

        # The parsed_option[:url] must be checked to avoid raising erros when only -h/-v are given
        exit(WPScan::ExitCode::VULNERABLE) if WPScan::ParsedCli.url && controllers.first.target.vulnerable?
        exit(WPScan::ExitCode::OK)
      end
    end
    # :nocov:

    # @return [ Integer ] The exit code related to the run_error
    def run_error_exit_code
      return WPScan::ExitCode::CLI_OPTION_ERROR if run_error.is_a?(OptParseValidator::Error) ||
                                                   run_error.is_a?(OptionParser::ParseError)

      return WPScan::ExitCode::INTERRUPTED if run_error.is_a?(Interrupt)

      return WPScan::ExitCode::ERROR if run_error.is_a?(WPScan::Error::Standard)

      WPScan::ExitCode::EXCEPTION
    end
  end
end
