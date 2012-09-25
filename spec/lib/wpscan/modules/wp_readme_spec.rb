#--
# WPScan - WordPress Security Scanner
# Copyright (C) 2012
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

shared_examples_for "WpReadme" do

  before :all do
    @module = WpScanModuleSpec.new('http://example.localhost')
    @fixtures_dir = SPEC_FIXTURES_WPSCAN_MODULES_DIR + '/wp_readme'

    @module.extend(WpReadme)
  end

  describe "#readme_url" do
    it "should return http://example.localhost/readme.html" do
      @module.readme_url.should === "#{@module.uri}/readme.html"
    end
  end

  describe "#has_readme?" do

    it "should return false on a 404" do
      stub_request(:get, @module.readme_url).
          to_return(:status => 404)

      @module.has_readme?.should be_false
    end

    it "should return true if it exists" do
      stub_request(:get, @module.readme_url).
          to_return(:status => 200, :body => File.new(@fixtures_dir + '/readme-3.2.1.html'))

      @module.has_readme?.should be_true
    end

    # http://code.google.com/p/wpscan/issues/detail?id=108
    it "should return true even if the readme.html is not in english" do
      stub_request(:get, @module.readme_url).
          to_return(:status => 200, :body => File.new(@fixtures_dir + '/readme-3.3.2-fr.html'))

      @module.has_readme?.should be_true
    end
  end

end
