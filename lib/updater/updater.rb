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

# This class act as an absract one
class Updater

  attr_reader :repo_directory

  # TODO : add a last '/ to repo_directory if it's not present
  def initialize(repo_directory = nil)
    @repo_directory = repo_directory
  end

  def is_installed?
    raise_must_be_implemented()
  end

  def local_revision_number
    raise_must_be_implemented()
  end

  def update
    raise_must_be_implemented()
  end

  protected

  def raise_must_be_implemented
    raise "The method must be implemented"
  end

end
