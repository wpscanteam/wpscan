# encoding: UTF-8

require 'common/cache_file_store'

# Implementaion of a cache_key (Typhoeus::Request#hash has too many options)
module Typhoeus
  class Request
    module Cacheable
      def cache_key
        Digest::SHA2.hexdigest("#{url}-#{options[:body]}-#{options[:method]}")[0..32]
      end
    end
  end
end

class TyphoeusCache < CacheFileStore

  def get(request)
    read_entry(request.cache_key)
  end

  def set(request, response)
    write_entry(request.cache_key, response, request.cache_ttl)
  end

end
