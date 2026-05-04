# frozen_string_literal: true

module WPScan
  module Controller
    # Base Controller
    class Base
      include OptParseValidator

      # @return [ Array<OptParseValidator::OptBase> ]
      def cli_options; end

      def before_scan; end

      def run; end

      def after_scan; end

      def ==(other)
        self.class == other.class
      end

      # Reset all the class attributes. Currently only used in specs.
      def self.reset
        @@target    = nil
        @@datastore = nil
        @@formatter = nil
      end

      # @return [ Target ]
      def target
        @@target ||= WPScan::Target.new(WPScan::ParsedCli.url, WPScan::ParsedCli.options)
      end

      # @param [ OptParseValidator::OptParser ] parser
      def self.option_parser=(parser)
        @@option_parser = parser
      end

      # @return [ OptParseValidator::OptParser ]
      def option_parser
        @@option_parser
      end

      # @return [ Hash ]
      def datastore
        @@datastore ||= {}
      end

      # @return [ Formatter::Base ]
      def formatter
        @@formatter ||= WPScan::Formatter.load(WPScan::ParsedCli.format, datastore[:views])
      end

      # @see Formatter#output
      #
      # @return [ Void ]
      def output(tpl, vars = {})
        formatter.output(*tpl_params(tpl, vars))
      end

      # @see Formatter#render
      #
      # @return [ String ]
      def render(tpl, vars = {})
        formatter.render(*tpl_params(tpl, vars))
      end

      # @return [ Boolean ]
      def user_interaction?
        formatter.user_interaction? && !WPScan::ParsedCli.output
      end

      # @return [ String ]
      def tmp_directory
        return Pathname.new(ENV['TMPDIR']).join(WPScan.app_name).to_s if ENV['TMPDIR']

        WPScan.user_cache_dir.to_s
      end

      protected

      # @param [ String ] tpl
      # @param [ Hash ] vars
      #
      # @return [ Array<String> ]
      def tpl_params(tpl, vars)
        [
          tpl,
          instance_variable_values.merge(vars),
          self.class.name.demodulize.underscore
        ]
      end

      # @return [ Hash ] All instance variable keys (and their values) plus the verbose value.
      def instance_variable_values
        h = { verbose: WPScan::ParsedCli.verbose }
        instance_variables.each do |a|
          s    = a.to_s
          n    = s[1..s.size]
          h[n.to_sym] = instance_variable_get(a)
        end
        h
      end
    end
  end
end
