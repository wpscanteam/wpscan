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

class UpdaterFactory

  def self.get_updater(repo_directory)
    self.available_updaters_classes().each do |updater_symbol|
      updater = Object.const_get(updater_symbol).new(repo_directory)

      if updater.is_installed?
        return updater
      end
    end
    nil
  end

  protected

  # return array of class symbols
  def self.available_updaters_classes
    Object.constants.grep(/^.+Updater$/)
  end

end
