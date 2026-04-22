# frozen_string_literal: true

module WPScan
  # Scan
  class Scan
    attr_reader :run_error

    def initialize
      NS.start_memory = GetProcessMem.new.bytes

      controllers << NS::Controller::Core.new

      exit_hook

      yield self if block_given?
    end

    # @return [ Controllers ]
    def controllers
      @controllers ||= NS::Controllers.new
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
        verbose: NS::ParsedCli.verbose || run_error_exit_code == NS::ExitCode::EXCEPTION
      }

      output_params[:url] = controllers.first.target.url if NS::ParsedCli.url

      formatter.output('@scan_aborted', output_params)
    ensure
      formatter.beautify
    end

    # Used for convenience
    # @See Formatter
    def formatter
      controllers.first.formatter
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
        exit(NS::ExitCode::VULNERABLE) if NS::ParsedCli.url && controllers.first.target.vulnerable?
        exit(NS::ExitCode::OK)
      end
    end
    # :nocov:

    # @return [ Integer ] The exit code related to the run_error
    def run_error_exit_code
      return NS::ExitCode::CLI_OPTION_ERROR if run_error.is_a?(OptParseValidator::Error) ||
                                               run_error.is_a?(OptionParser::ParseError)

      return NS::ExitCode::INTERRUPTED if run_error.is_a?(Interrupt)

      return NS::ExitCode::ERROR if run_error.is_a?(NS::Error::Standard) ||
                                    run_error.is_a?(WPScan::Error::Standard)

      NS::ExitCode::EXCEPTION
    end
  end
end
