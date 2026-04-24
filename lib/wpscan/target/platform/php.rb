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
          max_mib  = WPScan::ParsedCli.max_log_file_size.to_i
          max_size = max_mib.positive? ? max_mib * 1024 * 1024 : nil

          head_res = WPScan::Browser.forge_request(url(path), head_or_get_params).run
          return false unless head_res.code == 200

          if max_size
            content_length = head_res.headers&.[]('Content-Length').to_i
            return false if content_length > max_size
          end

          body = stream_capped_body(path, params, max_size)
          return false if body.nil?

          body.match?(pattern) || false
        end

        # Performs a streaming GET of `path` and returns the body as a String, capped at
        # `max_size` bytes. Returns nil if the transfer was aborted because it exceeded the cap.
        #
        # Only the first 700 bytes of the file are needed to match log-file patterns. Servers may
        # ignore the Range header, and libcurl's maxfilesize is a no-op when the response has no
        # Content-Length (chunked transfer encoding), so an on_body callback is used to abort the
        # transfer once the accumulated body exceeds the configured limit. Streaming via on_body
        # also keeps Typhoeus::Response#body empty, so the response cache cannot Marshal-dump a
        # huge payload.
        #
        # @param [ String ]       path
        # @param [ Hash ]         params The base request params
        # @param [ Integer, nil ] max_size Size cap in bytes, or nil to disable
        #
        # @return [ String, nil ]
        def stream_capped_body(path, params, max_size)
          get_params = params.merge(
            headers: { 'Range' => 'bytes=0-700' },
            method: :get,
            cache_ttl: 0
          )
          get_params[:maxfilesize] = max_size if max_size

          req  = WPScan::Browser.forge_request(url(path), get_params)
          body = +''
          aborted = install_body_cap(req, body, max_size)
          req.run

          aborted.call ? nil : body
        end

        # Installs an on_body callback on `req` that appends chunks to `body`. If `max_size` is
        # set, the transfer is aborted once the buffer exceeds it. Returns a callable that
        # reports whether the transfer was aborted.
        def install_body_cap(req, body, max_size)
          aborted = false

          if max_size
            req.on_body do |chunk|
              body << chunk
              next if body.bytesize <= max_size

              aborted = true
              :abort
            end
          else
            req.on_body { |chunk| body << chunk }
          end

          -> { aborted }
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
