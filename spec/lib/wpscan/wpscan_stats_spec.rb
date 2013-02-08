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

require File.expand_path(File.dirname(__FILE__) + '/wpscan_helper')

describe 'WpscanStats' do
  describe '#vuln_plugin_count' do
    it 'should return the correct number' do
      xml = "#{SPEC_FIXTURES_WPSCAN_WP_PLUGIN_DIR}/vulnerabilities/plugin_vulns.xml"
      WpscanStats.vuln_plugin_count(xml).should == 2
    end
  end

  describe '#vuln_theme_count' do
    it 'should return the correct number' do
      xml = "#{SPEC_FIXTURES_WPSCAN_WP_THEME_DIR}/vulnerabilities/theme_vulns.xml"
      WpscanStats.vuln_theme_count(xml).should == 2
    end
  end

  describe '#plugin_vulns_count' do
    it 'should return the correct number' do
      xml = "#{SPEC_FIXTURES_WPSCAN_WP_PLUGIN_DIR}/vulnerabilities/plugin_vulns.xml"
      WpscanStats.plugin_vulns_count(xml).should == 3
    end
  end

  describe '#theme_vulns_count' do
    it 'should return the correct number' do
      xml = "#{SPEC_FIXTURES_WPSCAN_WP_THEME_DIR}/vulnerabilities/theme_vulns.xml"
      WpscanStats.theme_vulns_count(xml).should == 3
    end
  end

  describe '#total_plugins' do
    xml = "#{SPEC_FIXTURES_WPSCAN_WP_PLUGIN_DIR}/vulnerabilities/plugin_vulns.xml"
    file = "#{SPEC_FIXTURES_WPSCAN_WP_PLUGIN_DIR}/plugins.txt"
    WpscanStats.total_plugins(file, xml).should == 4
  end

  describe '#total_themes' do
    xml = "#{SPEC_FIXTURES_WPSCAN_WP_THEME_DIR}/vulnerabilities/theme_vulns.xml"
    file = "#{SPEC_FIXTURES_WPSCAN_WP_THEME_DIR}/themes.txt"
    WpscanStats.total_themes(file, xml).should == 5
  end
end