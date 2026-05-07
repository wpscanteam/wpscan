# frozen_string_literal: true

module WPScan
  # Module for HTTP status code tracking and error detection
  module HttpStatusTracking
    # Tracking for HTTP status codes
    def status_codes
      @@status_codes_mutex ||= Mutex.new
      @@status_codes ||= Hash.new(0)
    end

    # Reset status codes (mainly for testing)
    def reset_status_codes
      @@status_codes_mutex ||= Mutex.new
      @@status_codes_mutex.synchronize do
        @@status_codes = Hash.new(0)
      end
    end

    # Thread-safe increment of status code count
    def increment_status_code(code)
      @@status_codes_mutex ||= Mutex.new
      @@status_codes_mutex.synchronize do
        status_codes[code] += 1
      end
    end

    # Thread-safe set of status code count (mainly for testing)
    def set_status_code(code, count)
      @@status_codes_mutex ||= Mutex.new
      @@status_codes_mutex.synchronize do
        status_codes[code] = count
      end
    end

    # Get top N status codes by frequency
    def top_status_codes(limit = 5)
      @@status_codes_mutex ||= Mutex.new
      @@status_codes_mutex.synchronize do
        return {} if status_codes.empty?

        status_codes.sort_by { |_code, count| -count }.first(limit).to_h
      end
    end

    # Helper to count specific error types
    def error_counts
      @@status_codes_mutex ||= Mutex.new
      @@status_codes_mutex.synchronize do
        {
          failed: status_codes[0] || 0,
          rate_limit: status_codes[429] || 0,
          server_errors: status_codes.select { |code, _| code >= 500 }.values.sum,
          client_errors: status_codes.select { |code, _count| code >= 400 && code < 500 && code != 404 }.values.sum
        }
      end
    end

    # Get a specific warning message based on error types
    def error_warning_message
      return nil if total_requests.zero?

      counts = error_counts
      error_percentage = (counts[:client_errors] + counts[:server_errors] + counts[:failed]).to_f / total_requests

      if counts[:failed] > 10
        'Too many failed requests (no response) could indicate network issues, ' \
          'WAF/IPS blocking, or an unavailable target'
      elsif counts[:rate_limit] > 10
        'Rate limiting detected (429 responses). Consider using --throttle or reducing --max-threads'
      elsif counts[:server_errors] > 10
        'Too many server errors (5xx). The target may be experiencing issues or blocking requests'
      elsif error_percentage > 0.2
        'Too many errors detected. This could indicate network issues, rate limiting, ' \
          'or security protection (e.g. WAF)'
      end
    end

    # Determine if warning should be shown for concerning error codes
    def concerning_error_codes?
      return false if total_requests.zero?

      counts = error_counts
      # Total errors excluding 404s but including failed requests (code 0)
      total_errors = counts[:client_errors] + counts[:server_errors] + counts[:failed]
      error_percentage = total_errors.to_f / total_requests

      # Warning conditions
      error_percentage > 0.2 ||
        counts[:rate_limit] > 10 ||
        counts[:server_errors] > 10 ||
        counts[:failed] > 10
    end
  end
end
