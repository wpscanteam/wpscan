# encoding: UTF-8
#--
# WPScan - WordPress Security Scanner
# Copyright (C) 2012-2013
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

# This Class Parses SVN Repositories via HTTP
class SvnParser

  attr_accessor :verbose, :svn_root, :keep_empty_dirs

  def initialize(svn_root)
    @svn_root    = svn_root
    @svn_browser = Browser.instance
    @svn_hydra   = @svn_browser.hydra
  end

  def parse
    get_root_directories
  end

  #Private methods start here
  private

  # Gets all directories in the SVN root
  def get_root_directories
    dirs      = []
    rootindex = @svn_browser.get(@svn_root).body

    rootindex.scan(%r{<li><a href=".+">(.+)/</a></li>}i).each do |dir|
      dirs << dir[0]
    end

    dirs.sort!
    dirs.uniq
  end
end
