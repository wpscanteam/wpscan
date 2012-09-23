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

require File.expand_path(File.dirname(__FILE__) + '/wpscan_helper')

describe WpPlugin do
  describe "#initialize" do
    it "should not raise an exception" do
      expect { WpPlugin.new(:base_url => "url", :path => "path", :wp_content_dir => "dir", :name => "name") }.to_not raise_error
    end

    it "should not raise an exception (wp_content_dir not set)" do
      expect { WpPlugin.new(:base_url => "url", :path => "path", :name => "name") }.to_not raise_error
    end

    it "should raise an exception (base_url not set)" do
      expect { WpPlugin.new(:path => "path", :wp_content_dir => "dir", :name => "name") }.to raise_error
    end

    it "should raise an exception (path not set)" do
      expect { WpPlugin.new(:base_url => "url", :wp_content_dir => "dir", :name => "name") }.to raise_error
    end

    it "should raise an exception (name not set)" do
      expect { WpPlugin.new(:base_url => "url", :path => "path", :wp_content_dir => "dir") }.to raise_error
    end
  end

  describe "#error_log_url" do
    it "should return a correct url" do
      temp = WpPlugin.new(:base_url => "http://wordpress.com",
                          :path => "test/asdf.php")
      temp.error_log_url.to_s.should == "http://wordpress.com/wp-content/plugins/test/error_log"
    end
  end

  describe "#error_log?" do
    before :each do
      @temp = WpPlugin.new(:base_url => "http://wordpress.com",
                           :path => "test/asdf.php")
    end

    it "should return true" do
      stub_request(:get, @temp.error_log_url.to_s).to_return(:status => 200, :body => "PHP Fatal error")
      @temp.error_log?.should be true
    end

    it "should return false" do
      stub_request(:get, @temp.error_log_url.to_s).to_return(:status => 500, :body => "Access denied")
      @temp.error_log?.should be false
    end

    it "should return true" do
      fixtures_dir = SPEC_FIXTURES_WPSCAN_WP_PLUGIN_DIR + "/error_log"
      stub_request(:get, @temp.error_log_url.to_s).to_return(:status => 200,
                                                             :body => File.new(fixtures_dir + '/error_log'))

      @temp.error_log?.should be true
    end
  end
end
