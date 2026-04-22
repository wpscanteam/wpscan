# frozen_string_literal: true

module CMSScanner
  module Formatter
    # CLI Formatter
    class Cli < Base
      # @return [ String ]
      def info_icon
        green('[+]')
      end

      # @return [ String ]
      def notice_icon
        blue('[i]')
      end

      # @return [ String ]
      def warning_icon
        amber('[!]')
      end

      # @return [ String ]
      def critical_icon
        red('[!]')
      end

      # @param [ String ] text
      # @return [ String ]
      def bold(text)
        colorize(text, 1)
      end

      # @param [ String ] text
      # @return [ String ]
      def red(text)
        colorize(text, 31)
      end

      # @param [ String ] text
      # @return [ String ]
      def green(text)
        colorize(text, 32)
      end

      # @param [ String ] text
      # @return [ String ]
      def amber(text)
        colorize(text, 33)
      end

      # @param [ String ] text
      # @return [ String ]
      def blue(text)
        colorize(text, 34)
      end

      # @param [ String ] text
      # @param [ Integer ] color_code
      # @return [ String ]
      def colorize(text, color_code)
        "\e[#{color_code}m#{text}\e[0m"
      end
    end
  end
end
