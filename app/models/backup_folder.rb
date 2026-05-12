# frozen_string_literal: true

module WPScan
  module Model
    # BackupFolder
    class BackupFolder < InterestingFinding
      attr_reader :response_code

      # @param [ String ] url
      # @param [ Hash ] opts
      # @option opts [ Integer ] :response_code
      def initialize(url, opts = {})
        super
        @response_code = opts[:response_code]
      end

      # @return [ String ]
      def to_s
        msg = "Backup folder found: #{url}"
        msg += ' (Directory listing enabled!)' if response_code == 200 && interesting_entries&.any?
        msg += ' (Access forbidden but folder exists)' if response_code == 403
        msg
      end

      # @return [ Symbol ]
      def severity
        return :high if response_code == 200 && interesting_entries&.any?
        return :medium if response_code == 200

        :low
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
