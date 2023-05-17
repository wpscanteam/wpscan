# frozen_string_literal: true

module WPScan
  module DB
    # Class used to perform DB updates
    # :nocov:
    class Updater
      # /!\ Might want to also update the Enumeration#cli_options when some filenames are changed here
      FILES = %w[
        metadata.json wp_fingerprints.json
        timthumbs-v3.txt config_backups.txt db_exports.txt
        dynamic_finders.yml LICENSE sponsor.txt
      ].freeze

      OLD_FILES = %w[
        wordpress.db user-agents.txt dynamic_finders_01.yml
        wordpresses.json plugins.json themes.json
      ].freeze

      attr_reader :repo_directory

      def initialize(repo_directory)
        @repo_directory = Pathname.new(repo_directory).expand_path

        FileUtils.mkdir_p(repo_directory.to_s) unless Dir.exist?(repo_directory.to_s)

        # When --no-update is passed, return to avoid raising an error if the directory is not writable
        # Mainly there for Homebrew: https://github.com/wpscanteam/wpscan/pull/1455
        return if ParsedCli.update == false

        unless repo_directory.writable?
          raise "#{repo_directory} is not writable (uid: #{Process.uid}, gid: #{Process.gid})"
        end

        delete_old_files
      end

      # Removes DB files which are no longer used
      # this doesn't raise errors if they don't exist
      def delete_old_files
        OLD_FILES.each do |old_file|
          FileUtils.remove_file(local_file_path(old_file), true)
        end
      end

      # @return [ Time, nil ]
      def last_update
        Time.parse(File.read(last_update_file))
      rescue ArgumentError, Errno::ENOENT
        nil # returns nil if the file does not exist or contains invalid time data
      end

      # @return [ String ]
      def last_update_file
        @last_update_file ||= repo_directory.join('.last_update').to_s
      end

      # @return [ Boolean ]
      def outdated?
        date = last_update

        date.nil? || date < 5.days.ago
      end

      # @return [ Boolean ]
      def missing_files?
        FILES.each do |file|
          return true unless File.exist?(repo_directory.join(file))
        end
        false
      end

      # @return [ Hash ] The params for Typhoeus::Request
      # @note Those params can't be overriden by CLI options
      def request_params
        @request_params ||= Browser.instance.default_request_params.merge(
          timeout: 600,
          connecttimeout: 300,
          accept_encoding: 'gzip, deflate',
          cache_ttl: 0,
          headers: { 'User-Agent' => Browser.instance.default_user_agent }
        )
      end

      # @return [ String ] The raw file URL associated with the given filename
      def remote_file_url(filename)
        "https://data.wpscan.org/#{filename}"
      end

      # @return [ String ] The checksum of the associated remote filename
      def remote_file_checksum(filename)
        url = "#{remote_file_url(filename)}.sha512"

        res = Typhoeus.get(url, request_params)
        raise Error::Download, res if res.timed_out? || res.code != 200

        res.body.chomp
      end

      # @return [ String ]
      def local_file_path(filename)
        repo_directory.join(filename.to_s).to_s
      end

      def local_file_checksum(filename)
        Digest::SHA512.file(local_file_path(filename)).hexdigest
      end

      # @return [ String ]
      def backup_file_path(filename)
        repo_directory.join("#{filename}.back").to_s
      end

      def create_backup(filename)
        return unless File.exist?(local_file_path(filename))

        FileUtils.cp(local_file_path(filename), backup_file_path(filename))
      end

      def restore_backup(filename)
        return unless File.exist?(backup_file_path(filename))

        FileUtils.cp(backup_file_path(filename), local_file_path(filename))
      end

      def delete_backup(filename)
        FileUtils.rm(backup_file_path(filename))
      end

      # @return [ String ] The checksum of the downloaded file
      def download(filename)
        file_path = local_file_path(filename)
        file_url  = remote_file_url(filename)

        res = Typhoeus.get(file_url, request_params)
        raise Error::Download, res if res.timed_out? || res.code != 200

        File.binwrite(file_path, res.body)

        local_file_checksum(filename)
      end

      # @return [ Array<String> ] The filenames updated
      def update
        updated = []

        FILES.each do |filename|
          db_checksum = remote_file_checksum(filename)

          # Checking if the file needs to be updated
          next if File.exist?(local_file_path(filename)) && db_checksum == local_file_checksum(filename)

          create_backup(filename)
          dl_checksum = download(filename)

          raise Error::ChecksumsMismatch, filename unless dl_checksum == db_checksum

          updated << filename
        rescue StandardError => e
          restore_backup(filename)
          raise e
        ensure
          delete_backup(filename) if File.exist?(backup_file_path(filename))
        end

        File.write(last_update_file, Time.now)

        updated
      end
    end
  end
  # :nocov:
end
