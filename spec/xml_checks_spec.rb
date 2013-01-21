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

describe "XML checks" do

  after :each do
    full_path = "#{DATA_DIR}/#@file"

    FileTest.exists?(full_path).should be_true

    if @xsd
      xsd = Nokogiri::XML::Schema(File.read(@xsd))
      doc = Nokogiri::XML(File.read(full_path))

      errors = []
      xsd.validate(doc).each do |error|
        errors << error.message
      end

      errors.should === []
    else
      expect { Nokogiri::XML(File.read(full_path)) { |config| config.strict } }.to_not raise_error
    end

  end

  it "check plugin_vulns.xml for syntax errors" do
    @file = "plugin_vulns.xml"
    @xsd = VULNS_XSD
  end

  it "check theme_vulns.xml for syntax errors" do
    @file = "theme_vulns.xml"
    @xsd = VULNS_XSD
  end

  it "check wp_versions.xml for syntax errors" do
    @file = "wp_versions.xml"
    @xsd = nil
  end

  it "check wp_vulns.xml for syntax errors" do
    @file = "wp_vulns.xml"
    @xsd = VULNS_XSD
  end

  it "check local_vulnerable_files.xml for syntax errors" do
    @file = "local_vulnerable_files.xml"
    @xsd = nil
  end
end