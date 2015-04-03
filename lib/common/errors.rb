
# HTTP Error
class HttpError < StandardError
  attr_reader :response

  # @param [ Typhoeus::Response ] res
  def initialize(response)
    @response = response
  end

  def failure_details
    msg = response.effective_url
    msg += response.code == 0 ? " (#{response.return_message})" : " (status: #{response.code})"
    msg
  end

  def message
    "HTTP Error: #{failure_details}"
  end
end

# Used in the Updater
class DownloadError < HttpError
  def message
    "Unable to get #{failure_details}"
  end
end
