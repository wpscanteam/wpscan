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

require File.expand_path(File.dirname(__FILE__) + '/updater')

class SvnUpdater < Updater

  REVISION_PATTERN = /revision="(\d+)"/i
  TRUNK_URL = "https://github.com/wpscanteam/wpscan"

  def is_installed?
    %x[svn info "#@repo_directory" --xml 2>&1] =~ /revision=/ ? true : false
  end

  def local_revision_number
    local_revision = %x[svn info "#@repo_directory" --xml 2>&1]
    local_revision[REVISION_PATTERN, 1].to_s
  end

  def update
    %x[svn up "#@repo_directory"]
  end

end
