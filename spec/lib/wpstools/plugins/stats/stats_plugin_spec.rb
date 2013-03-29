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

require File.expand_path(File.dirname(__FILE__) + '/../../wpstools_helper')

describe 'StatsPlugin' do
  subject(:stats)     { StatsPlugin.new }
  let(:plugins_vulns) { MODELS_FIXTURES + '/wp_plugin/vulnerable/plugins_vulns.xml' }
  let(:themes_vulns)  { MODELS_FIXTURES + '/wp_theme/vulnerable/themes_vulns.xml' }
  let(:plugins_file)  { COLLECTIONS_FIXTURES + '/wp_plugins/detectable/targets.txt' }
  let(:themes_file)   { COLLECTIONS_FIXTURES + '/wp_themes/detectable/targets.txt'}

  describe '#vuln_plugin_count' do
    it 'returns the correct number' do
      stats.vuln_plugin_count(plugins_vulns).should == 2
    end
  end

  describe '#vuln_theme_count' do
    it 'returns the correct number' do
      stats.vuln_theme_count(themes_vulns).should == 2
    end
  end

  describe '#plugin_vulns_count' do
    it 'returns the correct number' do
      stats.plugin_vulns_count(plugins_vulns).should == 3
    end
  end

  describe '#theme_vulns_count' do
    it 'returns the correct number' do
      stats.theme_vulns_count(themes_vulns).should == 3
    end
  end

  describe '#total_plugins' do
    it 'returns the correct numer' do
      stats.total_plugins(plugins_file).should == 3
    end
  end

  describe '#total_themes' do
    it 'returns the correct numer' do
      stats.total_themes(themes_file).should == 3
    end
  end
end
