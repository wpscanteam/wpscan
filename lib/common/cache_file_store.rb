# encoding: UTF-8

#
# => @todo take consideration of the cache_timeout :
#      -> create 2 files per key : one for the data storage (key.store ?)
#         and the other for the cache timeout (key.expiration, key.timeout ?)
#      or 1 file for all timeouts ?
#      -> 2 dirs : 1 for storage, the other for cache_timeout ?
#

require 'yaml'
require 'fileutils'

class CacheFileStore
  attr_reader :storage_path, :cache_dir, :serializer

  # The serializer must have the 2 methods .load and .dump
  #   (Marshal and YAML have them)
  # YAML is Human Readable, contrary to Marshal which store in a binary format
  # Marshal does not need any "require"
  def initialize(storage_path, serializer = Marshal)
    @cache_dir    = File.expand_path(storage_path)
    @storage_path = File.expand_path(File.join(storage_path, storage_dir))
    @serializer   = serializer

    unless Dir.exist?(@storage_path)
      FileUtils.mkdir_p(@storage_path)
    end
  end

  def clean
    # clean old directories
    Dir[File.join(@cache_dir, '*')].each do |f|
      if File.directory?(f)
        # delete directory if create time is older than 4 hours
        FileUtils.rm_rf(f) if File.mtime(f) < (Time.now - (60*240))
      else
        File.delete(f) unless File.symlink?(f)
      end
    end
  end

  def read_entry(key)
    begin
      @serializer.load(File.read(get_entry_file_path(key)))
    rescue
      nil
    end
  end

  def write_entry(key, data_to_store, cache_ttl)
    if cache_ttl && cache_ttl > 0
      File.open(get_entry_file_path(key), 'w') do |f|
        begin
          f.write(@serializer.dump(data_to_store))
        rescue
          nil # spec fix for "can't dump hash with default proc" when stub_request with  response headers
        end
      end
    end
  end

  def get_entry_file_path(key)
    File::join(@storage_path, key)
  end

  def storage_dir
    time   = Time.now
    random = (0...8).map { (65 + rand(26)).chr }.join

    Digest::MD5.hexdigest("#{time}#{random}")
  end

end
