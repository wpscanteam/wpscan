# encoding: UTF-8

require 'spec_helper'

describe 'JSON checks' do

  after :each do
    expect(FileTest.exists?(@file)).to be_truthy
    expect { JSON.parse(File.open(@file).read) }.not_to raise_error
  end

  it 'check plugin_vulns.json for syntax errors' do
    @file = PLUGINS_VULNS_FILE
  end

  it 'check theme_vulns.json for syntax errors' do
    @file = THEMES_VULNS_FILE
  end

  it 'check wp_vulns.json for syntax errors' do
    @file = WP_VULNS_FILE
  end
end

describe 'JSON content' do
  before :all do
    @vuln_plugins = json(PLUGINS_VULNS_FILE)
    @vuln_themes  = json(THEMES_VULNS_FILE)
    @vulnerabilities = @vuln_plugins + @vuln_themes
  end

  after :each do
    expect(@result.size).to eq(0), "Items:\n#{@result.join("\n")}"
  end

  it 'each asset vuln needs a title node' do
    @result = []

    @vulnerabilities.each do |plugin|
      plugin[plugin.keys.inject]['vulnerabilities'].each do |vulnerability|
        @result << vulnerability['title'] if vulnerability['title'].nil?
      end
    end
  end
end
