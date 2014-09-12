# encoding: UTF-8

require 'common/updater/updater'

# Updater for the Database (currently only 3 .json)
class DbUpdater < Updater
  FILES = %w(plugin_vulns.json theme_vulns.json wp_vulns.json)

  attr_reader :repo_directory

  def initialize(repo_directory)
    @repo_directory = repo_directory

    fail "#{repo_directory} is not writable" unless \
      Pathname.new(repo_directory).writable?
  end

  # @return [ Hash ] The params for Typhoeus::Request
  def request_params
    {
      ssl_verifyhost: 2,
      ssl_verifypeer: true
    }
  end

  # @return [ String ] The raw file URL associated with the given filename
  def remote_file_url(filename)
    "https://raw.githubusercontent.com/wpscanteam/vulndb/master/#{filename}"
  end

  # @return [ String ] The checksum of the associated remote filename
  def remote_file_checksum(filename)
    url = "#{remote_file_url(filename)}.sha512"

    res = Browser.get(url, request_params)
    fail "Unable to get #{url}" unless res.code == 200
    res.body
  end

  def local_file_path(filename)
    File.join(repo_directory, "#{filename}")
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
    FileUtils.rm(backup_file_path(filename), force: true)
  end

  # @return [ String ] The checksum of the downloaded file
  def download(filename)
    file_path = local_file_path(filename)
    file_url  = remote_file_url(filename)

    res = Browser.get(file_url, request_params)
    fail "Error while downloading #{file_url}" unless res.code == 200
    File.write(file_path, res.body.chomp)

    local_file_checksum(filename)
  end

  def update
    FILES.each do |filename|
      begin
        db_checksum = remote_file_checksum(filename)

        # Checking if the file needs to be updated
        next if File.exist?(local_file_path(filename)) &&
                db_checksum == local_file_checksum(filename)

        create_backup(filename)
        dl_checksum = download(filename)

        unless dl_checksum == db_checksum
          fail "#{filename}: checksums do not match"
        end
      rescue => e
        restore_backup(filename)
        raise e
      ensure
        delete_backup(filename)
      end
    end
  end
end
