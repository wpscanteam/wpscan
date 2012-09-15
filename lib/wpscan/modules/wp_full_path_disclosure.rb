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

module WpFullPathDisclosure

  # Check for Full Path Disclosure (FPD)
  def has_full_path_disclosure?
    response = Browser.instance.get(full_path_disclosure_url())
    response.body[%r{Fatal error}i]
  end

  def full_path_disclosure_url
    @uri.merge("wp-includes/rss-functions.php").to_s
  end
end
