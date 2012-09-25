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

class WpUser
  attr_accessor :name, :id, :nickname

  def initialize(name, id, nickname)
    @name     = name ? name : "empty"
    @id       = id ? id : "empty"
    @nickname = nickname ? nickname : "empty"
  end

  def <=>(item)
    item.name <=> @name
  end

  def ===(item)
    item.name === @name and item.id === @id and item.nickname === @nickname
  end

  def eql?(item)
    item.name === @name and item.id === @id and item.nickname === @nickname
  end
end