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

module WebSite

  #@error_404_hash = nil

  # Checks if the remote website is up.
  def online?
    Browser.instance.get(@uri.to_s).code != 0
  end

  def has_basic_auth?
    Browser.instance.get(@uri.to_s).code == 401
  end

  # check if the remote website is
  # actually running wordpress.
  def wordpress?
    wordpress = false

    response = Browser.instance.get(
      login_url(),
      {:follow_location => true, :max_redirects => 2}
    )

    if response.body =~ %r{WordPress}i
      wordpress = true
    else
      response = Browser.instance.get(
        xml_rpc_url,
        {:follow_location => true, :max_redirects => 2}
      )

      if response.body =~ %r{XML-RPC server accepts POST requests only}i
        wordpress = true
      end
    end

    wordpress
  end

  def has_xml_rpc?
    !xml_rpc_url.nil?
  end

  def xml_rpc_url
    unless @xmlrpc_url
      headers = Browser.instance.get(@uri.to_s).headers_hash
      value = headers["x-pingback"]
      if value.nil? or value.empty?
        @xmlrpc_url = nil
      else
        @xmlrpc_url = value
      end
    end
    @xmlrpc_url
  end

  # see if the remote url returns 30x redirect
  # return a string with the redirection or nil
  def redirection(url = nil)
    redirection = nil
    url ||= @uri.to_s
    response = Browser.instance.get(url)

    if response.code == 301 || response.code == 302
      redirection = response.headers_hash['location']
    end

    redirection
  end

  # Return the MD5 hash of a 404 page
  def error_404_hash
    unless @error_404_hash
      non_existant_page = Digest::MD5.hexdigest(rand(9999999999).to_s) + ".html"

      response = Browser.instance.get(@uri.merge(non_existant_page).to_s)

      @error_404_hash = Digest::MD5.hexdigest(response.body)
    end

    @error_404_hash
  end
end
