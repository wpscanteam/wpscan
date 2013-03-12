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
