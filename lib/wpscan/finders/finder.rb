# frozen_string_literal: true

require 'wpscan/finders/finder/smart_url_checker'
require 'wpscan/finders/finder/enumerator'
require 'wpscan/finders/finder/fingerprinter'
require 'wpscan/finders/finder/breadth_first_dictionary_attack'

module WPScan
  module Finders
    # Finder
    class Finder
      # Constants for common found_by
      DIRECT_ACCESS = 'Direct Access (Aggressive Detection)'

      attr_accessor :target, :progress_bar

      def initialize(target)
        @target = target
      end

      # @return [ String ] The titleized name of the finder
      def titleize
        # Put a _ char before any digits except those at the end, which will be replaced by a space
        # Otherwise, class such as Error404Page are returned as Error404 Page instead of Error 404 page
        # The keep_id_suffix is to concevert classes such as CssId to Css Id instead of Css

        @titleize ||= self.class.to_s.demodulize.gsub(/(\d+)[a-z]+/i, '_\0').titleize(keep_id_suffix: true)
      end

      # @param [ Hash ] _opts
      def passive(_opts = {}); end

      # @param [ Hash ] _opts
      def aggressive(_opts = {}); end

      # @param [ Hash ] opts See https://github.com/jfelchner/ruby-progressbar/wiki/Options
      # @option opts [ Boolean ] :show_progression
      #
      # @return [ ProgressBar::Base ]
      def create_progress_bar(opts = {})
        bar_opts          = { format: '%t %a <%B> (%c / %C) %P%% %e' }
        bar_opts[:output] = ProgressBarNullOutput unless opts[:show_progression]

        @progress_bar = ::ProgressBar.create(bar_opts.merge(opts))
      end

      # @return [ Browser ]
      def browser
        @browser ||= WPScan::Browser.instance
      end

      # @return [ Typhoeus::Hydra ]
      def hydra
        @hydra ||= browser.hydra
      end

      # @param [String, Class ] klass
      # @return [ String ]
      def found_by(klass = self.class)
        labels = %w[aggressive passive]

        caller_locations.each do |call|
          label = call.label
          # Since ruby 3.4, the label contains the full name, including module and class
          # rather than just the method like in ruby < 3.4
          label = label[/#(.*)/i, 1] if label.include?('#')

          next unless labels.include? label

          title = klass.to_s.demodulize.gsub(/(\d+)[a-z]+/i, '_\0').titleize(keep_id_suffix: true)

          return "#{title} (#{label.capitalize} Detection)"
        end
        nil
      end
    end
  end
end
