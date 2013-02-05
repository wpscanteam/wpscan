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

class WpUser

  def name
    if @name.nil? or @name.to_s.strip.empty?
      return 'empty'
    end
    @name
  end

  def name=(new_name)
    @name = new_name
  end

  def id
    if @id.nil? or @id.to_s.strip.empty?
      return 'empty'
    end
    @id
  end

  def id=(new_id)
    @id = new_id
  end

  def nickname
    if @nickname.nil? or @nickname.to_s.strip.empty?
      return 'empty'
    end
    @nickname
  end

  def nickname=(new_nickname)
    @nickname = new_nickname
  end

  def initialize(name, id, nickname)
    self.name = name
    self.id = id
    self.nickname = nickname
  end

  def <=>(other)
    other.name <=> self.name
  end

  def ==(other)
    other.name == self.name and other.id == self.id and other.nickname == self.nickname
  end

  def ===(other)
    other.name === self.name and other.id === self.id and other.nickname === self.nickname
  end

  def eql?(other)
    other.name === self.name and other.id === self.id and other.nickname === self.nickname
  end
end
