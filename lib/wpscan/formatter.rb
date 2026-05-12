# frozen_string_literal: true

require 'wpscan/formatter/buffer'

module WPScan
  # Formatter
  module Formatter
    # Module to be able to do Formatter.load() & Formatter.availables
    # and do that as well when the Formatter is included in another module
    module ClassMethods
      # @param [ String ] format
      # @param [ Array<String> ] custom_views
      #
      # @return [ Formatter::Base ]
      def load(format = nil, custom_views = nil)
        format ||= 'cli'
        custom_views ||= []

        f = const_get(format.tr('-', '_').camelize).new
        custom_views.each { |v| f.views_directories << v }
        f
      end

      # @return [ Array<String> ] The list of the available formatters (except the Base one)
      # @note: the #load method above should then be used to create the associated formatter
      def availables
        formatters = WPScan::Formatter.constants.select do |const|
          name = WPScan::Formatter.const_get(const)
          name.is_a?(Class) && name != WPScan::Formatter::Base
        end

        formatters.map { |sym| sym.to_s.underscore.dasherize }
      end
    end

    extend ClassMethods

    def self.included(base)
      base.extend(ClassMethods)
    end

    # This module should be implemented in the code which uses this Framework to
    # be able to override/implements instance methods for all the Formatters
    # w/o having to include/write the methods in each formatters.
    #
    # Example: to override the #views_directories (see the wpscan-v3/lib/wpscan/formatter.rb)
    module InstanceMethods
    end

    # Base Formatter
    class Base
      attr_reader :controller_name

      def initialize
        # Can't put this at the top level of the class, due to the WPScan::
        extend WPScan::Formatter::InstanceMethods
      end

      # @return [ String ] The underscored name of the class
      def format
        self.class.name.demodulize.underscore
      end

      # @return [ Boolean ]
      def user_interaction?
        format == 'cli'
      end

      # @return [ Boolean ]
      # Whether this formatter can render findings incrementally as they
      # arrive (cli, jsonl), or needs to receive the full result set first
      # (json, sarif — they emit a single well-formed document at end-of-scan).
      def streams?
        false
      end

      # @return [ String ] The underscored format to use as a base
      def base_format; end

      # @return [ Array<String> ]
      def formats
        [format, base_format].compact
      end

      # This is called after the scan
      # and used in some formatters (e.g JSON)
      # to indent results
      def beautify; end

      # @see #render
      def output(tpl, vars = {}, controller_name = nil)
        puts render(tpl, vars, controller_name)
      end

      ERB_SUPPORTS_KVARGS = ::ERB.instance_method(:initialize).parameters.assoc(:key) # Ruby 2.6+

      # @param [ String ] tpl
      # @param [ Hash ] vars
      # @param [ String ] controller_name
      def render(tpl, vars = {}, controller_name = nil)
        template_vars(vars)
        @controller_name = controller_name if controller_name

        # '-' disables new lines when -%> is used.
        # See http://www.ruby-doc.org/stdlib/libdoc/erb/rdoc/ERB.html
        ERB.new(File.read(view_path(tpl)), trim_mode: '-').result(binding)
      end

      # @param [ Hash ] vars
      #
      # @return [ Void ]
      def template_vars(vars)
        vars.each do |key, value|
          instance_variable_set("@#{key}", value) unless key == :views_directories
        end
      end

      # @param [ String ] tpl
      #
      # @return [ String ] The path of the view
      def view_path(tpl)
        if tpl[0, 1] == '@' # Global Template
          tpl = tpl.delete('@')
        else
          raise 'The controller_name can not be nil' unless controller_name

          tpl = "#{controller_name}/#{tpl}"
        end

        raise "Wrong tpl format: '#{tpl}'" unless %r{\A[\w/_]+\z}.match?(tpl)

        views_directories.reverse_each do |dir|
          formats.each do |format|
            potential_file = File.join(dir, format, "#{tpl}.erb")

            return potential_file if File.exist?(potential_file)
          end
        end

        raise "View not found for #{format}/#{tpl}"
      end

      # @return [ Array<String> ] The directories to look into for views
      def views_directories
        @views_directories ||= [
          APP_DIR, WPScan::APP_DIR,
          File.join(Dir.home, ".#{WPScan.app_name}"), File.join(Dir.pwd, ".#{WPScan.app_name}")
        ].uniq.reduce([]) { |acc, elem| acc << Pathname.new(elem).join('views').to_s }
      end
    end
  end
end
