# encoding: UTF-8
#
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

class Plugin

  attr_reader :author, :registered_options

  def initialize(infos = {})
    @author  = infos[:author]
  end

  def run(options = {})
    raise NotImplementedError
  end

  # param Array options
  def register_options(*options)
    options.each do |option|
      unless option.is_a?(Array)
        raise "Each option must be an array, #{option.class} supplied"
      end
    end
    @registered_options = options
  end

end
