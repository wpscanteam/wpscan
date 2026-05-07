# frozen_string_literal: true

module WPScan
  module Formatter
    # JSON Lines formatter — streams one self-contained JSON object per
    # template render as the scan progresses. Reuses every app/views/json/*.erb
    # template via base_format, so output content matches `-f json` but is
    # emitted incrementally and can be piped directly into tools like `jq`.
    class Jsonl < Base
      def base_format
        'json'
      end

      def output(tpl, vars = {}, controller_name = nil)
        rendered = render(tpl, vars, controller_name)
                   .encode('UTF-8', invalid: :replace, undef: :replace)
        fragment = rendered.strip.chomp(',')
        return if fragment.empty?

        $stdout.puts JSON.generate(JSON.parse("{#{fragment}}"))
        $stdout.flush
      end
    end
  end
end
