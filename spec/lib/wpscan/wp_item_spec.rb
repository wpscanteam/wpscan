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
  before :each do
    @instance = WpItem.new(:url             => "http://sub.example.com/path/to/wordpress/",
                           :path            => "plugins/test/asdf.php",
                           :vulns_xml       => "XXX.xml"
    )
  end

  describe "#initialize" do
    it "should create a correct instance" do
      @instance.wp_content_dir.should == "wp-content"
      @instance.url.should == "http://sub.example.com/path/to/wordpress/"
      @instance.path.should == "plugins/test/asdf.php"
    end
  end

  describe "#get_url" do
    it "should return the correct url" do
      @instance.get_url.to_s.should == "http://sub.example.com/path/to/wordpress/wp-content/plugins/test/asdf.php"
    end

    it "should return the correct url (custom wp_content_dir)" do
      @instance.wp_content_dir = "custom"
      @instance.get_url.to_s.should == "http://sub.example.com/path/to/wordpress/custom/plugins/test/asdf.php"
    end

    it "should trim / and add missing / before concatenating url" do
      @instance.wp_content_dir = "/custom/"
      @instance.url = "http://sub.example.com/path/to/wordpress"
      @instance.path = "plugins/test/asdf.php"
      @instance.get_url.to_s.should == "http://sub.example.com/path/to/wordpress/custom/plugins/test/asdf.php"
    end
  end

  describe "#get_url_without_filename" do
    it "should return the correct url" do
      @instance.get_url_without_filename.to_s.should == "http://sub.example.com/path/to/wordpress/wp-content/plugins/test/"
    end

    it "should return the correct url (custom wp_content_dir)" do
      @instance.wp_content_dir = "custom"
      @instance.get_url_without_filename.to_s.should == "http://sub.example.com/path/to/wordpress/custom/plugins/test/"
    end

    it "should trim / and add missing / before concatenating url" do
      @instance.wp_content_dir = "/custom/"
      @instance.url = "http://sub.example.com/path/to/wordpress"
      @instance.path = "plugins/test/asdf.php"
      @instance.get_url_without_filename.to_s.should == "http://sub.example.com/path/to/wordpress/custom/plugins/test/"
    end

    it "should not remove the last foldername" do
      @instance.path = "plugins/test/"
      @instance.get_url_without_filename.to_s.should == "http://sub.example.com/path/to/wordpress/wp-content/plugins/test/"
    end

    it "should return the correct url (https)" do
      @instance.url = "https://sub.example.com/path/to/wordpress/"
      @instance.get_url_without_filename.to_s.should == "https://sub.example.com/path/to/wordpress/wp-content/plugins/test/"
    end

    it "should add the last slash if it's not present" do
      @instance.path = "plugins/test-one"
      @instance.get_url_without_filename.to_s.should == "http://sub.example.com/path/to/wordpress/wp-content/plugins/test-one/"
    end
  end

  describe "#version" do
    let(:fixtures_dir) { SPEC_FIXTURES_WPSCAN_WP_PLUGIN_DIR + '/version' }
    it "should return a version number" do
      stub_request(:get, @instance.readme_url.to_s).to_return(:status => 200, :body => "Stable tag: 1.2.4.3.2.1")
      @instance.version.should == "1.2.4.3.2.1"
    end

    it "should not return a version number" do
      stub_request(:get, @instance.readme_url.to_s).to_return(:status => 200, :body => "Stable tag: trunk")
      @instance.version.should be nil
    end

    it "should return nil if the version is invalid (IE : trunk etc)" do
      stub_request(:get, @instance.readme_url.to_s).to_return(:status => 200,
                                                              :body => File.new(fixtures_dir + '/trunk-version.txt'))
      @instance.version.should be_nil
    end

    it "should return the version 0.4" do
      stub_request(:get, @instance.readme_url.to_s).to_return(:status => 200,
                                                              :body => File.new(fixtures_dir + '/simple-login-lockdown-0.4.txt'))

      @instance.version.should === "0.4"
    end
  end

  describe "#directory_listing?" do
    it "should return true" do
      stub_request(:get, @instance.get_url_without_filename.to_s).to_return(:status => 200,
                                                                            :body => "<html><head><title>Index of asdf</title></head></html>")
      @instance.directory_listing?.should == true
    end

    it "should return false" do
      stub_request(:get, @instance.get_url_without_filename.to_s).to_return(:status => 200,
                                                                            :body => "<html><head><title>My Wordpress Site</title></head></html>")
      @instance.directory_listing?.should == false
    end

    it "should return false on a 404" do
      stub_request(:get, @instance.get_url_without_filename.to_s.to_s).to_return(:status => 404)
      @instance.directory_listing?.should be_false
    end
  end

  describe "#extract_name_from_url" do
    it "should extract the correct name" do
      @instance.extract_name_from_url.should == "test"
    end

    it "should extract the correct name (custom wp_content_dir)" do
      @instance.wp_content_dir = "custom"
      @instance.extract_name_from_url.should == "test"
    end

    it "should extract the correct name" do
      @instance.wp_content_dir = "/custom/"
      @instance.url = "http://sub.example.com/path/to/wordpress"
      @instance.path = "plugins/test2/asdf.php"
      @instance.extract_name_from_url.should == "test2"
    end

    it "should extract the correct plugin name" do
      @instance.path = "plugins/testplugin/"
      @instance.extract_name_from_url.should == "testplugin"
    end

    it "should extract the correct theme name" do
      @instance.path = "themes/testtheme/"
      @instance.extract_name_from_url.should == "testtheme"
    end
  end

  describe "#to_s" do
    it "should return the name including a version number" do
      stub_request(:get, @instance.readme_url.to_s).to_return(:status => 200, :body => "Stable tag: 1.2.4.3.2.1")
      @instance.to_s.should == "test v1.2.4.3.2.1"
    end

    it "should not return the name without a version number" do
      stub_request(:get, @instance.readme_url.to_s).to_return(:status => 200, :body => "Stable tag: trunk")
      @instance.to_s.should == "test"
    end
  end

  describe "#==" do
    it "should return false" do
      instance2 = WpItem.new(:url             => "http://sub.example.com/path/to/wordpress/",
                             :path            => "plugins/newname/asdf.php",
                             :vulns_xml       => "XXX.xml"
      )
      (@instance==instance2).should == false
    end

    it "should return true" do
      instance2 = WpItem.new(:url             => "http://sub.example.com/path/to/wordpress/",
                             :path            => "plugins/test/asdf.php",
                             :vulns_xml       => "XXX.xml"
      )
      (@instance==instance2).should == true
    end
  end

  describe "#readme_url" do
    it "should return the corrent plugin readme url" do
      @instance.readme_url.to_s.should == "http://sub.example.com/path/to/wordpress/wp-content/plugins/test/readme.txt"
    end

    it "should return the corrent plugin readme url (custom wp_content)" do
      @instance.wp_content_dir = "custom"
      @instance.readme_url.to_s.should == "http://sub.example.com/path/to/wordpress/custom/plugins/test/readme.txt"
    end

    it "should return the corrent theme readme url" do
      @instance.path = "themes/test/asdf.php"
      @instance.readme_url.to_s.should == "http://sub.example.com/path/to/wordpress/wp-content/themes/test/readme.txt"
    end

    it "should return the corrent theme readme url (custom wp_content)" do
      @instance.wp_content_dir = "custom"
      @instance.path = "themes/test/asdf.php"
      @instance.readme_url.to_s.should == "http://sub.example.com/path/to/wordpress/custom/themes/test/readme.txt"
    end
  end

  describe "#changelog_url" do
    it "should return the corrent plugin changelog url" do
      @instance.changelog_url.to_s.should == "http://sub.example.com/path/to/wordpress/wp-content/plugins/test/changelog.txt"
    end

    it "should return the corrent plugin changelog url (custom wp_content)" do
      @instance.wp_content_dir = "custom"
      @instance.changelog_url.to_s.should == "http://sub.example.com/path/to/wordpress/custom/plugins/test/changelog.txt"
    end

    it "should return the corrent theme changelog url" do
      @instance.path = "themes/test/asdf.php"
      @instance.changelog_url.to_s.should == "http://sub.example.com/path/to/wordpress/wp-content/themes/test/changelog.txt"
    end

    it "should return the corrent theme changelog url (custom wp_content)" do
      @instance.wp_content_dir = "custom"
      @instance.path = "themes/test/asdf.php"
      @instance.changelog_url.to_s.should == "http://sub.example.com/path/to/wordpress/custom/themes/test/changelog.txt"
    end
  end

  describe "#has_readme?" do
    it "should return true" do
      stub_request(:get, @instance.readme_url.to_s).to_return(:status => 200)
      @instance.has_readme?.should == true
    end

    it "should return false" do
      stub_request(:get, @instance.readme_url.to_s).to_return(:status => 403)
      @instance.has_readme?.should == false
    end
  end

  describe "#has_changelog?" do
    it "should return true" do
      stub_request(:get, @instance.changelog_url.to_s).to_return(:status => 200)
      @instance.has_changelog?.should == true
    end

    it "should return false" do
      stub_request(:get, @instance.changelog_url.to_s).to_return(:status => 403)
      @instance.has_changelog?.should == false
    end
  end
end