# frozen_string_literal: true

module WPScan
  module Model
    # BackupFolder
    class BackupFolder < InterestingFinding
      MAX_ENTRIES_DISPLAY = 10

      # @return [ String ]
      def to_s
        msg = "Backup folder found: #{url}"
        if interesting_entries&.any?
          total = @interesting_entries.size
          msg += " (#{total} #{total == 1 ? 'entry' : 'entries'})"
        end
        msg
      end

      # @return [ Symbol ]
      def severity
        return :high if interesting_entries&.any?

        :medium
      end

      # Limit displayed entries to avoid overwhelming output
      # @return [ Array<String> ]
      def interesting_entries
        return [] unless @interesting_entries

        entries = @interesting_entries.first(MAX_ENTRIES_DISPLAY)
        if @interesting_entries.size > MAX_ENTRIES_DISPLAY
          entries << "... and #{@interesting_entries.size - MAX_ENTRIES_DISPLAY} more"
        end
        entries
      end
    end
  end
end
