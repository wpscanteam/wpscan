# frozen_string_literal: true

module WPScan
  module Finders
    module PluginVersion
      # Plugin Version Finder from the readme.txt file
      class Readme < CMSScanner::Finders::Finder
        # @return [ Version ]
        def aggressive(_opts = {})
          found_by_msg = 'Readme - %s (Aggressive Detection)'

          # The target(plugin)#readme_url can't be used directly here
          # as if the --detection-mode is passive, it will always return nil
          target.potential_readme_filenames.each do |file|
            res = target.head_and_get(file)

            next unless res.code == 200 && !(numbers = version_numbers(res.body)).empty?

            return numbers.reduce([]) do |a, e|
              a << Model::Version.new(
                e[0],
                found_by: format(found_by_msg, e[1]),
                confidence: e[2],
                interesting_entries: [res.effective_url]
              )
            end
          end

          nil
        end

        # @return [ Array<String, String, Integer> ] number, found_by, confidence
        def version_numbers(body)
          numbers = []

          if (number = from_stable_tag(body))
            numbers << [number, 'Stable Tag', 80]
          end

          if (number = from_changelog_section(body))
            numbers << [number, 'ChangeLog Section', 50]
          end

          numbers
        end

        # @param [ String ] body
        #
        # @return [ String, nil ] The version number detected from the stable tag
        def from_stable_tag(body)
          return unless body =~ /\b(?:stable tag|version):\s*(?!trunk)([0-9a-z\.-]+)/i

          number = Regexp.last_match[1]

          number if /[0-9]+/.match?(number)
        end

        # @param [ String ] body
        #
        # @return [ String, nil ] The best version number detected from the changelog section
        def from_changelog_section(body)
          extracted_versions = body.scan(%r{[=]+\s+(?:v(?:ersion)?\s*)?([0-9\.-]+)[ \ta-z0-9\(\)\.\-\/]*[=]+}i)

          return if extracted_versions.nil? || extracted_versions.empty?

          extracted_versions.flatten!
          # must contain at least one number
          extracted_versions = extracted_versions.select { |x| x =~ /[0-9]+/ }

          sorted = extracted_versions.sort do |x, y|
            Gem::Version.new(x) <=> Gem::Version.new(y)
          rescue StandardError
            0
          end

          sorted.last
        end
      end
    end
  end
end
