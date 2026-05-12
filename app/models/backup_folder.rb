# frozen_string_literal: true

module WPScan
  module Model
    # BackupFolder
    class BackupFolder < InterestingFinding
      MAX_ENTRIES_DISPLAY = 5

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

      # @return [ String ]
      def plugin_name
        @plugin_name ||= detect_plugin_from_path
      end

      # Plugin path patterns mapped to plugin names
      # Minimal set - additional plugins can be added in follow-up PRs
      PLUGIN_PATTERNS = {
        /backups-dup-pro/i => 'Duplicator Pro',
        /backups-dup-lite/i => 'Duplicator',
        /updraft/i => 'UpdraftPlus',
        %r{uploads/db-backup}i => 'WP Database Backup',
        /backup-db/i => 'WP-DB-Backup',
        %r{uploads/backwpup}i => 'BackWPup'
      }.freeze

      private

      # @return [ String ]
      def detect_plugin_from_path
        PLUGIN_PATTERNS.each do |pattern, name|
          return name if url.match?(pattern)
        end
        'Unknown Backup Plugin'
      end
    end
  end
end
