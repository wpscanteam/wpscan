# frozen_string_literal: true

module WPScan
  class Target < WebSite
    module Platform
      # Some PHP specific implementation
      module PHP
        DEBUG_LOG_PATTERN = /(?:\[\d{2}-[a-zA-Z]{3}-\d{4}\s\d{2}:\d{2}:\d{2}\s[A-Z]{3}\]|
                              PHP\s(?:Fatal|Warning|Strict|Error|Notice):)/x
        FPD_PATTERN       = /Fatal error:.+? in (.+?) on/
        ERROR_LOG_PATTERN = /PHP Fatal error/i

        # @param [ String ] path
        # @param [ Regexp ] pattern
        # @param [ Hash ] params The request params
        #
        # @return [ Boolean ]
        def log_file?(path, pattern, params = {})
          # Only the first 700 bytes of the file are retrieved to avoid getting entire log file
          # which can be huge (~ 2Go)
          res = head_and_get(path, [200], get: params.merge(headers: { 'Range' => 'bytes=0-700' }))

          res.body&.match?(pattern) || false
        end

        # @param [ String ] path
        # @param [ Hash ] params The request params
        #
        # @return [ Boolean ] true if  url(path) is a debug log, false otherwise
        def debug_log?(path, params = {})
          log_file?(path, DEBUG_LOG_PATTERN, params)
        end

        # @param [ String ] path
        # @param [ Hash ] params The request params
        #
        # @return [ Boolean ] Wether or not url(path) is an error log file
        def error_log?(path, params = {})
          log_file?(path, ERROR_LOG_PATTERN, params)
        end

        # @param [ String ] path
        # @param [ Hash ] params The request params
        #
        # @return [ Boolean ] true if url(path) contains a FPD, false otherwise
        def full_path_disclosure?(path = nil, params = {})
          !full_path_disclosure_entries(path, params).empty?
        end

        # @param [ String ] path
        # @param [ Hash ] params The request params
        #
        # @return [ Array<String> ] The FPD found, or an empty array if none
        def full_path_disclosure_entries(path = nil, params = {})
          res = WPScan::Browser.get(url(path), params)

          res.body.scan(FPD_PATTERN).flatten
        end
      end
    end
  end
end
