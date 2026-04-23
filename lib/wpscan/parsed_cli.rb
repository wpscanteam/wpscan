# frozen_string_literal: true

module WPScan
  # Holds the parsed CLI options and exposes them via class methods (e.g. #verbose?)
  # rather than from the raw hash. Similar to an OpenStruct but class-wise, with extra
  # logic to push browser-relevant options into the Browser singleton.
  class ParsedCli
    # @return [ Hash ]
    def self.options
      @options ||= {}
    end

    # Sets the CLI options and propagates them to the Browser.
    # @param [ Hash ] options
    def self.options=(options)
      @options = options.dup || {}

      WPScan::Browser.reset
      WPScan::Browser.instance(@options)
    end

    # @return [ Boolean ]
    def self.verbose?
      options[:verbose] ? true : false
    end

    # Unknown methods return nil — expected behaviour for option lookups.
    # rubocop:disable Style/MissingRespondToMissing
    def self.method_missing(method_name, *_args, &_block)
      super if method_name == :new

      options[method_name.to_sym]
    end
    # rubocop:enable Style/MissingRespondToMissing
  end
end
