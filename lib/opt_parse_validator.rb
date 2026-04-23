# frozen_string_literal: true

# Gems
require 'addressable/uri'
require 'active_support/inflector'
require 'active_support/core_ext/hash'
# Standard Libs
require 'optparse'
require 'pathname'
# Custom Libs
require 'opt_parse_validator/errors'
require 'opt_parse_validator/hacks'
require 'opt_parse_validator/opts'
require 'opt_parse_validator/version'
require 'opt_parse_validator/config_files_loader_merger' # Could even create a gem out of it, as completely independent

# Gem namespace
module OptParseValidator
  # Validator
  class OptParser < OptionParser
    attr_reader :symbols_used, :opts

    def initialize(banner = nil, width = 32, indent = ' ' * 4)
      @results      = {}
      @symbols_used = []
      @opts         = []

      super
    end

    # @return [ OptParseValidator::ConfigFilesLoaderMerger ]
    def config_files
      @config_files ||= ConfigFilesLoaderMerger.new
    end

    # @param [ Array<OptBase> ] options
    #
    # @return [ Self ] For chaining #new.add.results
    def add(*options)
      options.each do |option|
        check_option(option)

        @opts << option
        @symbols_used << option.to_sym

        # Set the default option value if it exists
        # The default value is not validated as it is provided by devs
        # and should be set to the correct format/value directly
        @results[option.to_sym] = option.default unless option.default.nil?

        register_callback(option)
      end

      self
    end

    # @return [ Hash ]
    def results(argv = default_argv)
      load_config_files
      parse!(argv)
      post_processing

      @results
    rescue StandardError => e
      # Raise it as an OptParseValidator::Error if not already one
      raise e.is_a?(Error) ? e.class : Error, e.message
    end

    # @return [ String ] The simplified help (without any of the advanced option/s listed)
    def simple_help
      help = to_s

      # Removes all advanced help messages
      @opts.select(&:advanced?).each do |opt|
        messages_pattern = //

        opt.help_messages.each do |msg|
          messages_pattern = /#{messages_pattern}\s*#{Regexp.escape(msg)}/
        end

        pattern = /\s*#{Regexp.escape(opt.option[0..1].select { |o| o[0] == '-' }.join(', '))}#{messages_pattern}/

        help.gsub!(pattern, '')
      end

      help
    end

    # @return [ String ] The full help, with the advanced option/s listed
    def full_help
      to_s
    end

    protected

    # Ensures the opt given is valid
    #
    # @param [ OptBase ] opt
    #
    # @return [ void ]
    def check_option(opt)
      raise Error, "The option is not an OptBase, #{opt.class} supplied" unless opt.is_a?(OptBase)
      raise Error, "The option #{opt.to_sym} is already used !" if @symbols_used.include?(opt.to_sym)
    end

    # @param [ OptBase ] opt
    #
    # @return [ void ]
    def register_callback(opt)
      on(*opt.option) do |arg|
        if opt.alias?
          parse!(opt.alias_for.split)
        else
          @results[opt.to_sym] = opt.normalize(opt.validate(arg))
        end
      rescue StandardError => e
        # Adds the long option name to the message
        # And raises it as an OptParseValidator::Error if not already one
        # e.g --proxy Invalid Scheme format.
        raise e.is_a?(Error) ? e.class : Error, "#{opt.to_long} #{e}"
      end
    end

    # @return [ Void ]
    def load_config_files
      files_data = config_files.parse

      @opts.each do |opt|
        next unless files_data.key?(opt.to_sym)

        begin
          @results[opt.to_sym] = opt.normalize(opt.validate(files_data[opt.to_sym].to_s))
        rescue StandardError => e
          # Adds the long option name to the message
          # And raises it as an OptParseValidator::Error if not already one
          # e.g --proxy Invalid Scheme format.
          raise e.is_a?(Error) ? e.class : Error, "#{opt.to_long} #{e}"
        end
      end
    end

    # Ensure that all required options are supplied
    # Should be overriden to modify the behavior
    #
    # @return [ Void ]
    def post_processing
      @opts.each do |opt|
        raise NoRequiredOption, "The option #{opt.to_long} is required" if opt.required? && !@results.key?(opt.to_sym)

        next if opt.required_unless.empty? || @results.key?(opt.to_sym)

        fail_msg = 'One of the following options is required: ' \
                   "#{opt.to_long}, --#{opt.required_unless.join(', --').tr('_', '-')}"

        raise NoRequiredOption, fail_msg unless opt.required_unless.any? do |sym|
          @results.key?(sym)
        end
      end
    end
  end
end
