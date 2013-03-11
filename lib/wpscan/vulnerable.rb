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

class Vulnerable

  attr_reader :vulns_file, :vulns_xpath

  # @return an array of WpVulnerability (can be empty)
  def vulnerabilities
    xml             = xml(@vulns_file)
    vulnerabilities = []

    xml.xpath(@vulns_xpath).each do |node|
      vulnerabilities << WpVulnerability.new(
        node.search('title').text,
        node.search('reference').map(&:text),
        node.search('type').text,
        node.search('metasploit').map(&:text)
      )
    end
    vulnerabilities
  end

end
