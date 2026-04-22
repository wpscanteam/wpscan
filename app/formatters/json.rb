# frozen_string_literal: true

module CMSScanner
  module Formatter
    # JSON Formatter
    class Json < Base
      include Buffer

      def beautify
        puts JSON.pretty_generate(JSON.parse("{#{buffer.chomp.chomp(',')}}"))
      end
    end
  end
end
