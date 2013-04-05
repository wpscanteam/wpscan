# encoding: UTF-8

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
