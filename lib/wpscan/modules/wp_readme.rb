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

module WpReadme

  # Checks to see if the readme.html file exists
  #
  # This file comes by default in a wordpress installation,
  # and if deleted is reinstated with an upgrade.
  def has_readme?
    response = Browser.instance.get(readme_url())

    unless response.code == 404
      response.body =~ %r{wordpress}i
    end
  end

  def readme_url
    @uri.merge("readme.html").to_s
  end
end
