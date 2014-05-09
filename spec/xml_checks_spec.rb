# encoding: UTF-8

require 'spec_helper'

describe 'XSD checks' do

  after :each do
    FileTest.exists?(@file).should be_true

    xsd = Nokogiri::XML::Schema(File.read(@xsd))
    doc = Nokogiri::XML(File.read(@file))

    errors = []
    xsd.validate(doc).each do |error|
      errors << "#{@file}:#{error.line}: #{error.message}"
    end

    unless errors.empty?
      fail errors.join("\n")
    end
  end

  it 'check plugin_vulns.xml for syntax errors' do
    @file = PLUGINS_VULNS_FILE
    @xsd  = VULNS_XSD
  end

  it 'check theme_vulns.xml for syntax errors' do
    @file = THEMES_VULNS_FILE
    @xsd  = VULNS_XSD
  end

  it 'check wp_versions.xml for syntax errors' do
    @file = WP_VERSIONS_FILE
    @xsd  = WP_VERSIONS_XSD
  end

  it 'check wp_vulns.xml for syntax errors' do
    @file = WP_VULNS_FILE
    @xsd  = VULNS_XSD
  end

  it 'check local_vulnerable_files.xml for syntax errors' do
    @file = LOCAL_FILES_FILE
    @xsd  = LOCAL_FILES_XSD
  end
end

describe 'Well formed XML checks' do
  after :each do
    FileTest.exists?(@file).should be_true

    begin
      Nokogiri::XML(File.open(@file)) { |config| config.options = Nokogiri::XML::ParseOptions::STRICT }
    rescue Nokogiri::XML::SyntaxError => e
      fail "#{@file}:#{e.line},#{e.column}: #{e.message}"
    end
  end

  it 'check plugin_vulns.xml for syntax errors' do
    @file = PLUGINS_VULNS_FILE
  end

  it 'check theme_vulns.xml for syntax errors' do
    @file = THEMES_VULNS_FILE
  end

  it 'check wp_versions.xml for syntax errors' do
    @file = WP_VERSIONS_FILE
  end

  it 'check wp_vulns.xml for syntax errors' do
    @file = WP_VULNS_FILE
  end

  it 'check local_vulnerable_files.xml for syntax errors' do
    @file = LOCAL_FILES_FILE
  end
end

describe 'XML content' do
  before :all do
    @vuln_plugins = xml(PLUGINS_VULNS_FILE)
    @vuln_themes = xml(THEMES_VULNS_FILE)
  end

  after :each do
    @result.should have(0).items, "Items:\n#{@result.join("\n")}"
  end

  it 'each plugin vuln needs a type node' do
    @result = @vuln_plugins.xpath('//vulnerability[not(type)]/title/text()').map(&:text)
  end

  it 'each theme vuln needs a type node' do
    @result = @vuln_themes.xpath('//vulnerability[not(type)]/title/text()').map(&:text)
  end

  it 'each plugin vuln needs a title node' do
    @result = @vuln_plugins.xpath('//vulnerability[not(title)]/../@name').map(&:text)
  end

  it 'each theme vuln needs a title node' do
    @result = @vuln_themes.xpath('//vulnerability[not(title)]/../@name').map(&:text)
  end

  it 'each plugin vuln needs a references node' do
    @result = @vuln_plugins.xpath('//vulnerability[not(references)]/title/text()').map(&:text)
  end

  it 'each theme vuln needs a references node' do
    @result = @vuln_themes.xpath('//vulnerability[not(references)]/title/text()').map(&:text)
  end
end
