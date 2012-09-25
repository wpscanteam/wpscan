#--
# WPScan - WordPress Security Scanner
# Copyright (C) 2012
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#++

#
# => @todo take consideration of the cache_timeout :
#      -> create 2 files per key : one for the data storage (key.store ?) and the other for the cache timeout (key.expiration, key.timeout ?)
#      or 1 file for all timeouts ?
#      -> 2 dirs : 1 for storage, the other for cache_timeout ?
#

require 'yaml'

class CacheFileStore
  attr_reader :storage_path, :serializer

  # The serializer must have the 2 methods .load and .dump (Marshal and YAML have them)
  # YAML is Human Readable, contrary to Marshal which store in a binary format
  # Marshal does not need any "require"
  def initialize(storage_path, serializer = Marshal)
    @storage_path = File.expand_path(storage_path)
    @serializer = serializer

    # File.directory? for ruby <= 1.9 otherwise, it makes more sense to do Dir.exist? :/
    unless File.directory?(@storage_path)
      Dir.mkdir(@storage_path)
    end
  end

  def clean
    Dir[File.join(@storage_path, '*')].each do |f|
      File.delete(f)
    end
  end

  def read_entry(key)
    entry_file_path = get_entry_file_path(key)

    if File.exists?(entry_file_path)
      return @serializer.load(File.read(entry_file_path))
    end
  end

  def write_entry(key, data_to_store, cache_timeout)
    if cache_timeout > 0
      File.open(get_entry_file_path(key), 'w') do |f|
        f.write(@serializer.dump(data_to_store))
      end
    end
  end

  def get_entry_file_path(key)
    @storage_path + '/' + key
  end

end
