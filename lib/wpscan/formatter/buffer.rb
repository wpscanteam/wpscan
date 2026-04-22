# frozen_string_literal: true

module CMSScanner
  module Formatter
    # Module used to output the rendered views into a buffer
    # and beautify it a the end of the scan
    module Buffer
      def output(tpl, vars = {}, controller_name = nil)
        buffer << render(tpl, vars, controller_name).encode('UTF-8', invalid: :replace, undef: :replace)
      end

      def buffer
        @buffer ||= +''
      end
    end
  end
end
