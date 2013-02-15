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

require 'spec_helper'

describe 'wpscan main checks' do

  it 'should check for errors on running the mainscript' do
    a = %x[ruby #{ROOT_DIR}/wpscan.rb]
    a.should =~ /\[ERROR\] No argument supplied/
  end

  it 'should check for valid syntax' do
    result = ""
    Dir.glob("**/*.rb") do |file|
      res = %x{ruby -c #{ROOT_DIR}/#{file} 2>&1}.split("\n")
      ok = res.select {|msg| msg =~ /Syntax OK/}
      result << ("####################\nSyntax error in #{file}:\n#{res.join("\n").strip()}\n") if ok.size != 1
    end
    fail(result) unless result.empty?
  end
end
