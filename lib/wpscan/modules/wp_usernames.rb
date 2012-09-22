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

module WpUsernames

  # Enumerate wordpress usernames by using Veronica Valeros's technique:
  # http://seclists.org/fulldisclosure/2011/May/493
  #
  # Available options :
  #  :range - default : 1..10
  #
  # returns an array of WpUser (can be empty)
  def usernames(options = {})
    range = options[:range] || (1..10)
    browser = Browser.instance
    usernames = []

    range.each do |author_id|
      url = author_url(author_id)
      response = browser.get(url)

      username = nil
      nickname = nil
      if response.code == 301 # username in location?
        username = response.headers_hash['location'][%r{/author/([^/]+)/}i, 1]
        # Get the real name from the redirect site
        nickname = get_nickname_from_url(url)
      elsif response.code == 200 # username in body?
        username = response.body[%r{posts by (.*) feed}i, 1]
        nickname = get_nickname_from_response(response)
      end

      unless username == nil and nickname == nil
        usernames << WpUser.new(username, author_id, nickname)
      end
    end
    usernames = remove_junk_from_nickname(usernames)

    # clean the array, remove nils and possible duplicates
    usernames.flatten!
    usernames.compact!
    usernames.uniq
  end

  def get_nickname_from_url(url)
    resp = Browser.instance.get(url, {:follow_location => true, :max_redirects => 2})
    nickname = nil
    if resp.code == 200
      nickname = extract_nickname_from_body(resp.body)
    end
    nickname
  end

  def get_nickname_from_response(resp)
    nickname = nil
    if resp.code == 200
      nickname = extract_nickname_from_body(resp.body)
    end
    nickname
  end

  def extract_nickname_from_body(body)
    body[%r{<title>([^<]*)</title>}i, 1]
  end

  def remove_junk_from_nickname(usernames)
    unless usernames.kind_of? Array
      raise("Need an array as input")
    end
    nicknames = []
    usernames.each do |u|
      unless u.kind_of? WpUser
        raise("Items must be of type WpUser")
      end
      nickname = u.nickname
      unless nickname == "empty"
        nicknames << nickname
      end
    end
    junk = get_equal_string_end(nicknames)
    usernames.each do |u|
      u.nickname = u.nickname.sub(/#{Regexp.escape(junk)}$/, "")
    end
    usernames
  end

  def author_url(author_id)
    @uri.merge("?author=#{author_id}").to_s
  end
end
