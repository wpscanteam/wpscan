#
# WPScan - WordPress Security Scanner
# Copyright (C) 2011  Ryan Dewhurst AKA ethicalhack3r
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
#

module WpUsernames

  # Enumerate wordpress usernames by using Veronica Valeros's technique:
  # http://seclists.org/fulldisclosure/2011/May/493
  #
  # Available options :
  #  :range - default : 1..10
  #
  # returns an array of usernames (can be empty)
  def usernames(options = {})
    range       = options[:range] || (1..10)
    browser     = Browser.instance
    usernames   = []

    range.each do |author_id|
      response = browser.get(author_url(author_id))

      if response.code == 301 # username in location?
        usernames << response.headers_hash['location'][%r{/author/([^/]+)/}i, 1]
      elsif response.code == 200 # username in body?
        usernames << response.body[%r{posts by (.*) feed}i, 1]
      end
    end

    # clean the array, remove nils and possible duplicates
    usernames.flatten!
    usernames.compact!
    usernames.uniq
  end

  def author_url(author_id)
    @uri.merge("?author=#{author_id}").to_s
  end
end
