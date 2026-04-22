# frozen_string_literal: true

module CMSScanner
  module Finders
    class Finder
      module SmartURLChecker
        # Findings
        class Findings < Array
          def <<(finding)
            return self unless finding

            each do |f|
              next unless f == finding && f.found_by == finding.found_by

              # This makes sure entries added are unique
              # and prevent pages redirecting to the same one to be added twice
              entries_to_add = finding.interesting_entries - f.interesting_entries
              return self if entries_to_add.empty?

              entries_to_add.each { |entry| f.interesting_entries << entry }

              f.confidence += finding.confidence

              return self
            end

            super
          end
        end
      end
    end
  end
end
