# encoding: UTF-8

require 'common/cache_file_store'

class TyphoeusCache < CacheFileStore

  def get(request)
    read_entry(request.hash.to_s)
  end

  def set(request, response)
    write_entry(request.hash.to_s, response, request.cache_ttl)
  end

end
