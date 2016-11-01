
# HTTP Error
class HttpError < StandardError
  attr_reader :response

  # @param [ Typhoeus::Response ] response
  def initialize(response)
    @response = response
  end

  def failure_details
    msg = response.effective_url

    if response.code == 0 || response.timed_out?
      msg += " (#{response.return_message})"
    else
      msg += " (status: #{response.code})"
    end

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

class ChecksumError < StandardError
  attr_reader :file

  def initialize(file)
    @file = file
  end
end
