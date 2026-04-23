# frozen_string_literal: true

module WPScan
  # Scope system logic
  class Target < WebSite
    # @return [ Array<PublicSuffix::Domain, String> ]
    def scope
      @scope ||= Scope.new
    end

    # @param [ String, Addressable::URI ] url An absolute URL or URI
    #
    # @return [ Boolean ] true if the url given is in scope
    def in_scope?(url_or_uri)
      url_or_uri = Addressable::URI.parse(url_or_uri.strip) unless url_or_uri.is_a?(Addressable::URI)

      scope.include?(url_or_uri.host)
    rescue StandardError
      false
    end

    # @param [ Typhoeus::Response ] res
    # @param [ String ] xpath
    #
    # @yield [ Addressable::URI, Nokogiri::XML::Element ] The in scope url and its associated tag
    #
    # @return [ Array<Addressable::URI> ] The in scope absolute URIs detected in the response's body
    #
    # @note It is highly recommended to use the xpath parameter to focus on the uris needed, as this method can be quite
    #       time consuming when there are a lof of uris to check
    def in_scope_uris(res, xpath = '//@href|//@src|//@data-src')
      found = []

      uris_from_page(res, xpath) do |uri, tag|
        next unless in_scope?(uri)

        yield uri, tag if block_given?

        found << uri
      end

      found
    end

    # Similar to Target#url_pattern but considering the in scope domains as well
    #
    # @return [ Regexp ] The pattern related to the target url and in scope domains,
    #                    it also matches escaped /, such as in JSON JS data: http:\/\/t.com\/
    # rubocop:disable Metrics/AbcSize
    def scope_url_pattern
      return @scope_url_pattern if @scope_url_pattern

      domains = [uri.host + uri.path]

      domains += if scope.domains.empty?
                   Array(scope.invalid_domains[1..])
                 else
                   Array(scope.domains[1..]).map(&:to_s) + scope.invalid_domains
                 end

      domains.map! { |d| Regexp.escape(d.delete_suffix('/')).gsub('\*', '.*').gsub('/', '\\\\\?/') }

      domains[0].gsub!(Regexp.escape(uri.host), "#{Regexp.escape(uri.host)}(?::\\d+)?") if uri.port

      @scope_url_pattern = %r{https?:\\?/\\?/(?:#{domains.join('|')})\\?/?}i
    end
    # rubocop:enable Metrics/AbcSize

    # Scope Implementation
    class Scope
      # @return [ Array<PublicSuffix::Domain> ] The valid domains in scope
      def domains
        @domains ||= []
      end

      # @return [ Array<String> ] The invalid domains in scope (such as IP addresses etc)
      def invalid_domains
        @invalid_domains ||= []
      end

      def <<(element)
        if PublicSuffix.valid?(element, ignore_private: true)
          domains << PublicSuffix.parse(element, ignore_private: true)
        else
          invalid_domains << element
        end
      end

      # @return [ Boolean ] Wether or not the host is in the scope
      def include?(host)
        if PublicSuffix.valid?(host, ignore_private: true)
          domain = PublicSuffix.parse(host, ignore_private: true)

          domains.each { |d| return true if domain.match(d) }
        else
          invalid_domains.each { |d| return true if host == d }
        end

        false
      end
    end
  end
end
