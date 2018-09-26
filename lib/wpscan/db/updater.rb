module WPScan
  module DB
    # Class used to perform DB updates
    # :nocov:
    class Updater
      # /!\ Might want to also update the Enumeration#cli_options when some filenames are changed here
      FILES = %w[
        plugins.json themes.json wordpresses.json
        timthumbs-v3.txt user-agents.txt config_backups.txt
        db_exports.txt dynamic_finders.yml wp_fingerprints.json LICENSE
      ].freeze

      OLD_FILES = %w[wordpress.db dynamic_finders_01.yml].freeze

      attr_reader :repo_directory

      def initialize(repo_directory)
        @repo_directory = repo_directory

        FileUtils.mkdir_p(repo_directory) unless Dir.exist?(repo_directory)

        raise "#{repo_directory} is not writable" unless Pathname.new(repo_directory).writable?

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
        @last_update_file ||= File.join(repo_directory, '.last_update')
      end

      # @return [ Boolean ]
      def outdated?
        date = last_update

        date.nil? || date < 5.days.ago
      end

      # @return [ Boolean ]
      def missing_files?
        FILES.each do |file|
          return true unless File.exist?(File.join(repo_directory, file))
        end
        false
      end

      # @return [ Hash ] The params for Typhoeus::Request
      def request_params
        {
          ssl_verifyhost: 2,
          ssl_verifypeer: true,
          timeout: 300,
          connecttimeout: 120,
          accept_encoding: 'gzip, deflate',
          cache_ttl: 0
        }
      end

      # @return [ String ] The raw file URL associated with the given filename
      def remote_file_url(filename)
        "https://data.wpscan.org/#{filename}"
      end

      # @return [ String ] The checksum of the associated remote filename
      def remote_file_checksum(filename)
        url = "#{remote_file_url(filename)}.sha512"

        res = Browser.get(url, request_params)
        raise DownloadError, res if res.timed_out? || res.code != 200

        res.body.chomp
      end

      def local_file_path(filename)
        File.join(repo_directory, filename.to_s)
      end

      def local_file_checksum(filename)
        Digest::SHA512.file(local_file_path(filename)).hexdigest
      end

      def backup_file_path(filename)
        File.join(repo_directory, "#{filename}.back")
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

        res = Browser.get(file_url, request_params)
        raise DownloadError, res if res.timed_out? || res.code != 200

        File.open(file_path, 'wb') { |f| f.write(res.body) }

        local_file_checksum(filename)
      end

      # @return [ Array<String> ] The filenames updated
      def update
        updated = []

        FILES.each do |filename|
          begin
            db_checksum = remote_file_checksum(filename)

            # Checking if the file needs to be updated
            next if File.exist?(local_file_path(filename)) && db_checksum == local_file_checksum(filename)

            create_backup(filename)
            dl_checksum = download(filename)

            raise "#{filename}: checksums do not match" unless dl_checksum == db_checksum

            updated << filename
          rescue StandardError => e
            restore_backup(filename)
            raise e
          ensure
            delete_backup(filename) if File.exist?(backup_file_path(filename))
          end
        end

        File.write(last_update_file, Time.now)

        updated
      end
    end
  end
  # :nocov:
end
