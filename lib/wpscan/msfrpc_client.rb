#!/usr/bin/env ruby

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

# This library should contain all methods to communicate with msfrpc.
# See framework/documentation/msfrpc.txt for further information.
# msfrpcd -S -U wpscan -P wpscan -f -t Web -u /RPC2
# name = exploit/unix/webapp/php_include

class RpcClient

  def initialize
    @config = {}
    @config['host'] = "127.0.0.1"
    @config['path'] = "/RPC2"
    @config['port'] = 55553
    @config['user'] = "wpscan"
    @config['pass'] = "wpscan"
    @auth_token = nil
    @last_auth = nil

    begin
       @server = XMLRPC::Client.new3( :host => @config["host"], :path => @config["path"], :port =>  @config["port"], :user => @config["user"], :password => @config["pass"])
    rescue => e
      puts "[ERROR] Could not create XMLRPC object."
      puts e.faultCode
      puts e.faultString
    end
  end

  # login to msfrpcd

  def login()
    result = @server.call("auth.login", @config['user'], @config['pass'])

    if result['result'] == "success"
      @auth_token = result['token']
      @last_auth = Time.new
      logged_in = true
    else
      puts "[ERROR] Invalid login credentials provided to msfrpcd."
      logged_in = false
    end
   
  end

  # check authentication
 
  def authenticate()
    login() if @auth_token.nil?
    login() if (Time.now - @last_auth > 600)
  end

  # retrieve information about the exploit

  def get_exploit_info(name)
    authenticate()
    @server.call('module.info', @auth_token, 'exploit', name)
  end

  # retrieve exploit options

  def get_options(name)
    authenticate()
    @server.call('module.options', @auth_token, 'exploit',name)
  end

  # retrieve the exploit payloads

  def get_payloads(name)
    authenticate()
    @server.call('module.compatible_payloads', @auth_token, name)
  end

  # execute exploit

  def exploit(name, opts)
    authenticate()
    @server.call('module.execute', @auth_token, 'exploit', name, opts)
  end
 
  # list msf jobs

  def jobs()
    authenticate()
    @server.call('job.list', @auth_token)
  end

  # list msf sessions

  def sessions()
    authenticate()
    @server.call('session.list', @auth_token)
  end

  # kill msf session

  def kill_session(id)
    authenticate()
    @server.call('session.stop', @auth_token, id)
  end

  # reads any pending output from session

  def read_shell(id)
    authenticate()
    @server.call('session.shell_read', @auth_token, id)
  end

  # writes the specified input into the session

  def write_shell(id, data)
    authenticate()
    @server.call('session.shell_write', @auth_token, id, data)
  end

  def meterpreter_read(id)
    authenticate()
    @server.call('session.meterpreter_read', @auth_token, id)
  end

  def meterpreter_write(id, data)
    authenticate()
    @server.call('session.meterpreter_write', @auth_token, id, data)
  end

end
